defmodule LenraServices.ActionBuilder do
  @moduledoc """
    The service to build an app based on a listener.
  """

  require Logger

  alias LenraServers.JsonValidator
  alias LenraServers.Storage
  alias LenraServices.Openfaas

  @type ow_info :: {String.t(), String.t()}
  @type event :: map()
  @type ui :: map()
  @type ui_patch :: list(map())

  @doc """
    This function build the first UI with default Entry Point `"InitData"` to generate the data model and `"MainUi"` to generate the UI
  """
  @spec first_run(ow_info()) :: {:ok, ui()} | {:error, String.t()}
  def first_run(ow_info) do
    with {:ok, data} <- get_data(ow_info),
         {:ok, final_ui} <- run_app_listener(ow_info, "InitData", data, %{}, %{}) do
      {:ok, final_ui}
    end
  end

  @doc """
    This function build the UI using the given `action_key` to generate the data model and `"MainUi"` to generate the UI
  """
  @spec listener_run(ow_info(), String.t(), event()) :: {:ok, ui_patch()} | {:error, String.t()}
  def listener_run(ow_info, action_key, event) do
    with {:ok, old_data} <- get_data(ow_info),
         {:ok, {action_code, props}} <- get_listener(action_key),
         {:ok, last_final_ui} <- get_last_final_ui(ow_info),
         {:ok, final_ui} <- run_app_listener(ow_info, action_code, old_data, props, event),
         patch <- JSONDiff.diff(last_final_ui, final_ui) do
      {:ok, patch}
    end
  end

  defp save_final_ui({client_id, app_name}, final_ui) do
    final_ui_key = Storage.generate_final_ui_key(client_id, app_name)
    Storage.insert(:final_ui, final_ui_key, final_ui)
    {:ok, final_ui}
  end

  defp save_data({client_id, app_name}, data) do
    case Lenra.Repo.get_by(Lenra.LenraApplication, name: app_name) do
      nil -> {:error, :no_such_application}
      application -> {:ok, LenraServices.DatastoreServices.upsert_data(client_id, application.id, data)}
    end
  end

  defp get_last_final_ui({client_id, app_name}) do
    final_ui_key = Storage.generate_final_ui_key(client_id, app_name)

    case Storage.get(:final_ui, final_ui_key) do
      nil -> {:error, "Could not get Old Final Ui"}
      final_ui -> {:ok, final_ui}
    end
  end

  defp build_ui(%{"root" => base_component} = ui) do
    with {:ok, builded_base_component} <- rec_build_ui(base_component) do
      {:ok, Map.put(ui, "root", builded_base_component)}
    end
  end

  @spec rec_build_ui(map()) :: {:ok, map()} | {:error, String.t()}
  def rec_build_ui(component)

  @doc """
    Build recursively the given component and return the builded component.
    The UI can be :
     - A container -> The function will build all children recursively
     - A listener component -> The function will build the listener
     - Any other : Nothing happend, return self.
  """

  # Container case. Run recursivly for all children. Return builded container with updated children
  def rec_build_ui(%{"children" => children} = container) when is_list(children) do
    Enum.reduce_while(children, {:ok, []}, fn child, {:ok, acc} ->
      case rec_build_ui(child) do
        {:ok, new_child} -> {:cont, {:ok, acc ++ [new_child]}}
        {:error, _} = err -> {:halt, err}
      end
    end)
    |> case do
      {:ok, new_children} -> {:ok, Map.put(container, "children", new_children)}
      err -> err
    end
  end

  # listener case. Save all listeners and return modified listener element with data replacement
  def rec_build_ui(%{"listeners" => listeners_map} = component) when is_map(listeners_map) do
    with {:ok, new_listeners} <- save_and_encode_listeners(listeners_map) do
      {
        :ok,
        Map.put(component, "listeners", new_listeners)
      }
    end
  end

  # Base case, return same component
  def rec_build_ui(component) do
    {:ok, component}
  end

  defp save_and_encode_listeners(listeners_map) do
    Enum.reduce_while(
      listeners_map,
      {:ok, %{}},
      fn
        {event_name, %{"action" => action_code} = listener}, {:ok, acc} ->
          props = Map.get(listener, "props", %{})
          listener_key = Storage.generate_listeners_key(action_code, props)
          Storage.insert(:listeners, listener_key, listener)
          {:cont, {:ok, Map.put(acc, event_name, %{"code" => listener_key})}}

        _, _ ->
          {:halt, {:error, "All listener must have an action name."}}
      end
    )
  end

  defp run_app_listener({_client_id, app_name} = ow_info, action_code, old_data, props, event) do
    with {:ok, %{"data" => data, "ui" => ui}} <-
           Openfaas.run_action(app_name, action_code, %{
             data: old_data,
             props: props,
             event: event
           }),
         {:ok, "Schema valide"} <- JsonValidator.validate_ui(ui),
         {:ok, final_ui} <- build_ui(ui),
         {:ok, _} <- save_final_ui(ow_info, final_ui),
         {:ok, _} <- save_data(ow_info, data) do
      {:ok, final_ui}
    end
  end

  defp get_listener(action_key) do
    case Storage.get(:listeners, action_key) do
      %{"action" => name, "props" => props} -> {:ok, {name, props}}
      %{"action" => name} -> {:ok, {name, %{}}}
      nil -> {:error, "No listener found."}
    end
  end

  defp get_data({client_id, app_name}) do
    case Lenra.Repo.get_by(Lenra.LenraApplication, name: app_name) do
      nil -> {:error, :no_such_application}
      application -> {:ok, LenraServices.DatastoreServices.get_datastore_data(client_id, application.id)}
    end
  end
end
