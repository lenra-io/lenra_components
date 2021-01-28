defmodule LenraWeb.AppChannel do
  @moduledoc """
    `LenraWeb.AppChannel` handle the app channel to run app and listeners and push to the user the resulted UI or Patch
  """
  use Phoenix.Channel

  require Logger

  def join("app", %{"app" => app_name}, socket) do
    client_id = "42"
    socket = assign(socket, app_name: app_name, client_id: client_id)

    case LenraServices.ActionBuilder.first_run({client_id, app_name}) do
      {:ok, ui} ->
        send(self(), {:send_ui, ui})

      {:error, reason} ->
        Logger.error(inspect(reason))
    end

    {:ok, socket}
  end

  def join("app", _any, _socket) do
    {:error, %{reason: "No App Name"}}
  end

  def handle_info({:send_ui, ui}, socket) do
    push(socket, "ui", ui)
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

    case LenraServices.ActionBuilder.listener_run({client_id, app_name}, action_key, event) do
      {:ok, patch} ->
        push(socket, "patchUi", %{patch: patch})

      {:error, reason} ->
        Logger.error(reason)
    end

    {:noreply, socket}
  end
end
