defmodule LenraWeb.AppsController do
  use LenraWeb, :controller
  require Logger

  def index(conn, _params) do
    with {:ok, raw_app_list} <- LenraServices.Openfaas.fetch_app_list(),
         app_list <- Enum.map(raw_app_list, fn %{"name" => app_name} -> %{"name" => app_name} end) do
      conn
      |> assign_data(:apps, app_list)
      |> reply
    else
      {:error, error_message} ->
        conn
        |> assign_error(error_message)
        |> reply
    end
  end
end
