defmodule LenraWeb.AppsController do
  use LenraWeb, :controller

  def index(conn, _params) do
    case LenraServices.Openwhisk.run_app_list() do
      {:ok, to_send} -> json(conn, to_send)
      {:error, error_message} -> conn |> put_status(500) |> json(%{error: error_message})
    end
  end
end
