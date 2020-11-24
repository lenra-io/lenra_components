defmodule LenraWeb.AppsController do
  use LenraWeb, :controller
  require Logger

  def index(conn, _params) do
    with {:ok, app_list} <- LenraServices.Openfaas.fetch_app_list(),
         to_send <- Enum.map(app_list, fn %{"name" => app_name} -> %{"name" => app_name} end) do
      json(conn, to_send)
    else
      {:error, error_message} ->
        Logger.debug(error_message)

        conn
        |> put_status(500)
        |> json(%{error: error_message})
    end
  end
end
