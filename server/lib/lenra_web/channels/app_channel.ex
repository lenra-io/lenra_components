defmodule LenraWeb.AppChannel do
  @moduledoc """
    `LenraWeb.AppChannel` handle the app channel to run app and listeners and push to the user the resulted UI or Patch
  """
  use Phoenix.Channel

  require Logger

  def join("app", %{"app" => app_name}, socket) do
    client_id = 42
    socket = assign(socket, app_name: app_name, client_id: client_id)

    LenraServers.AppQueueHandler.push(
      client_id,
      :ui,
      LenraServices.ActionBuilder,
      :first_run,
      [{client_id, app_name}],
      self()
    )

    {:ok, socket}
  end

  def join("app", _any, _socket) do
    {:error, %{reason: "No App Name"}}
  end

  def handle_info({:ui, res}, socket) do
    case res do
      {:ok, ui} ->
        push(socket, "ui", ui)

      {:error, reason} ->
        Logger.error(reason)
    end

    {:noreply, socket}
  end

  def handle_info({:patch_ui, res}, socket) do
    case res do
      {:ok, patch} ->
        push(socket, "patchUi", %{patch: patch})

      {:error, reason} ->
        Logger.error(reason)
    end

    {:noreply, socket}
  end

  def handle_in("run", %{"code" => action_key, "event" => event}, socket) do
    handle_run(socket, action_key, event)
  end

  def handle_in("run", %{"code" => action_key}, socket) do
    handle_run(socket, action_key)
  end

  defp handle_run(socket, action_key, event \\ %{}) do
    %{app_name: app_name, client_id: client_id} = socket.assigns

    LenraServers.AppQueueHandler.push(
      client_id,
      :patch_ui,
      LenraServices.ActionBuilder,
      :listener_run,
      [{client_id, app_name}, action_key, event],
      self()
    )

    {:noreply, socket}
  end
end
