defmodule LenraServices.ActionBuilder do
  @moduledoc """
    The service to build an app based on a listener.
  """

  require Logger

  alias LenraServers.Storage, as: Storage
  alias LenraServices.Openfaas, as: Openfaas

  @type ow_info :: {String.t(), String.t()}
  @type event :: map()
  @type ui :: map()
  @type ui_patch :: list(map())

  @doc """
    This function build the first UI with default Entry Point `"InitData"` to generate the data model and `"MainUi"` to generate the UI
  """
  @spec first_run(ow_info()) :: {:ok, ui()} | {:error, String.t()}
  def first_run(ow_info) do
    with {:ok, data} <- run_data(ow_info, "InitData", %{}, %{}, %{}),
         {:ok, final_ui} <- build_ui(ow_info, %{}, data, "MainUi") do
      save_final_ui(ow_info, final_ui)
    end
  end

  @doc """
    This function build the UI using the given `action_key` to generate the data model and `"MainUi"` to generate the UI
  """
  @spec listener_run(ow_info(), String.t(), event()) :: {:ok, ui_patch()} | {:error, String.t()}
  def listener_run(ow_info, action_key, event) do
    with {:ok, {old_data, data}} <- run_listener_data(ow_info, action_key, event),
         {:ok, final_ui} <- build_ui(ow_info, old_data, data, "MainUi"),
         {:ok, last_final_ui} <- get_last_final_ui(ow_info),
         {:ok, _} <- save_final_ui(ow_info, final_ui),
         patch <- JSONDiff.diff(last_final_ui, final_ui) do
      {:ok, patch}
    end
  end

  defp save_final_ui({client_id, app_name}, final_ui) do
    final_ui_key = Storage.generate_final_ui_key(client_id, app_name)
    Storage.insert(:final_ui, final_ui_key, final_ui)
    {:ok, final_ui}
  end

  defp get_last_final_ui({client_id, app_name}) do
    final_ui_key = Storage.generate_final_ui_key(client_id, app_name)

    case Storage.get(:final_ui, final_ui_key) do
      nil -> {:error, "Could not get Old Final Ui"}
      final_ui -> {:ok, final_ui}
    end
  end

  defp build_ui(ow_info, old_data, data, ui_action_code) do
    with {:ok, %{"root" => base_component}} <- run_ui(ow_info, ui_action_code, old_data, data),
         {:ok, builded_base_component} <- rec_build_ui(ow_info, base_component, old_data, data) do
      {:ok, %{"root" => builded_base_component}}
    end
  end

  @spec rec_build_ui(ow_info(), map(), map(), map()) :: {:ok, map()} | {:error, String.t()}
  def rec_build_ui(ow_info, component, old_data, data)

  @doc """
    Build recursively the given component and return the builded component.
    The UI can be :
     - A container -> The function will build all children recursively
     - A base component -> The function will bind the data
     - A listener component -> The function will build the listener and bind the data
     - A sub-ui -> The function replace the component with the builded corresponding UI
  """

  # Container case. Run recursivly for all children. Return builded container with updated children
  def rec_build_ui(ow_info, %{"children" => children} = container, old_data, data)
      when is_list(children) do
    with {:ok, new_children} <- call_async_children(ow_info, children, old_data, data) do
      {:ok, Map.put(container, "children", new_children)}
    end
  end

  # listener case. Save all listeners and return modified listener element with data replacement
  def rec_build_ui(
        ow_info,
        %{"listeners" => listeners_map} = component,
        _old_data,
        data
      )
      when is_map(listeners_map) do
    with {:ok, new_listeners} <- save_and_encode_listeners(ow_info, listeners_map) do
      {
        :ok,
        component
        |> Map.merge(%{"listeners" => new_listeners})
        |> Utils.DataManipulation.replace_keys(data)
      }
    end
  end

  # Sub ui case, run sub ui and return it
  def rec_build_ui(
        ow_info,
        %{"type" => "ui", "name" => action_code} = sub_ui,
        old_data,
        data
      ) do
    with props <- Map.get(sub_ui, "props", %{}),
         cache <- Map.get(sub_ui, "cache", :none),
         {:ok, %{"root" => component}} <-
           run_ui(ow_info, action_code, old_data, data, props, cache) do
      rec_build_ui(ow_info, component, old_data, data)
    end
  end

  # Base case, return same component
  def rec_build_ui(_ow_info, component, _old_data, data) do
    {:ok, Utils.DataManipulation.replace_keys(component, data)}
  end

  defp save_and_encode_listeners({client_id, app_name}, listeners_map) do
    Enum.reduce_while(
      listeners_map,
      {:ok, %{}},
      fn
        {event_name, %{"name" => action_code} = listener}, {:ok, acc} ->
          props = Map.get(listener, "props", %{})
          listener_key = Storage.generate_listeners_key(client_id, app_name, action_code, props)
          Storage.insert(:listeners, listener_key, listener)
          {:cont, {:ok, Map.put(acc, event_name, %{"code" => listener_key})}}

        _, _ ->
          {:halt, {:error, "All listener must have a name."}}
      end
    )
  end

  defp call_async_children(ow_info, children, old_data, data) do
    children
    |> Enum.map(
      &Task.async(LenraServices.ActionBuilder, :rec_build_ui, [ow_info, &1, old_data, data])
    )
    |> Enum.reduce_while({:ok, []}, fn task, {:ok, acc} ->
      case Task.await(task) do
        {:ok, child} -> {:cont, {:ok, acc ++ [child]}}
        {:error, _} = err -> {:halt, err}
      end
    end)
  end

  defp run_ui(ow_info, action_code, old_data, data, props \\ %{}, cache \\ :none) do
    with {:ok, ui} <- get_ui(ow_info, action_code, props),
         false <- must_rebuild_ui?(ui, old_data, data) do
      Logger.info("Get UI from Internal Cache")
      {:ok, ui}
    else
      _ ->
        case cache do
          :none ->
            run_and_save_ui(ow_info, action_code, data, props)

          cache ->
            Logger.info("Get UI from App Cache")
            save_ui(ow_info, action_code, props, cache)
        end
    end
  end

  defp must_rebuild_ui?(%{"updateOn" => update_key_list}, old_data, new_data) do
    Enum.any?(update_key_list, fn key ->
      with old_value <- Utils.DataManipulation.get_data_from_key(key, old_data),
           new_value <- Utils.DataManipulation.get_data_from_key(key, new_data) do
        old_value != new_value
      end
    end)
  end

  defp must_rebuild_ui?(_any, _old_data, _new_data) do
    false
  end

  defp run_and_save_ui({_client_id, app_name} = ow_action, action_code, data, props) do
    with {:ok, ui} <-
           Openfaas.run_action(app_name, action_code, %{
             data: data,
             props: props
           }) do
      save_ui(ow_action, action_code, props, ui)
    end
  end

  defp save_ui({client_id, app_name}, action_code, props, ui) do
    ui_key = Storage.generate_ui_key(client_id, app_name, action_code, props)
    Storage.insert(:ui, ui_key, ui)
  end

  defp run_listener_data(ow_info, action_key, ui_event) do
    with {:ok, old_data} <- get_data(ow_info),
         {:ok, {action_code, props}} <- get_listener(action_key),
         {:ok, data} <- run_data(ow_info, action_code, old_data, props, ui_event) do
      {:ok, {old_data, data}}
    end
  end

  defp run_data({client_id, app_name}, action_code, old_data, props, event) do
    with {:ok, data} <-
           Openfaas.run_action(app_name, action_code, %{
             data: old_data,
             props: props,
             event: event
           }),
         data_key <- Storage.generate_data_key(client_id, app_name) do
      Storage.insert(:data, data_key, data)
    end
  end

  defp get_listener(action_key) do
    case Storage.get(:listeners, action_key) do
      %{"name" => name, "props" => props} -> {:ok, {name, props}}
      %{"name" => name} -> {:ok, {name, %{}}}
      nil -> {:error, "No listener found."}
    end
  end

  defp get_data({client_id, app_name}) do
    with data_key <- Storage.generate_data_key(client_id, app_name) do
      case Storage.get(:data, data_key) do
        nil -> {:error, "No data found."}
        data -> {:ok, data}
      end
    end
  end

  defp get_ui({client_id, app_name}, action_code, props) do
    with ui_key <- Storage.generate_ui_key(client_id, app_name, action_code, props) do
      case Storage.get(:ui, ui_key) do
        nil -> {:error, "No ui Found"}
        data -> {:ok, data}
      end
    end
  end
end
