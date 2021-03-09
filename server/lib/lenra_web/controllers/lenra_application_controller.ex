defmodule LenraWeb.AppsController do
  use LenraWeb, :controller
  require Logger

  alias Lenra.{Repo, LenraApplication}
  alias LenraServices.LenraApplicationServices

  def index(conn, _params) do
    raw_app_list = Repo.all(LenraApplication)
    app_list = Enum.map(raw_app_list, fn app -> %{"name" => app.name, "icon" => app.icon, "color" => app.color} end)

    conn
    |> assign_data(:apps, app_list)
    |> reply
  end

  def create(conn, params) do
    res =
      Guardian.Plug.current_resource(conn)
      |> LenraApplicationServices.create_and_deploy(params)

    conn
    |> handle_create(res)
    |> reply
  end

  defp handle_create(conn, {:error, _, failed_value, _}) do
    assign_error(conn, failed_value)
  end

  defp handle_create(conn, {:ok, app}) do
    assign(conn, :openfaas_app, app)
  end

  def delete(conn, %{"id" => app_name}) do
    res =
      case LenraApplicationServices.get_by(name: app_name) do
        nil ->
          {:error, :error_404}

        app ->
          LenraApplicationServices.delete_and_undeploy(app)
      end

    conn
    |> handle_delete(res)
    |> reply
  end

  defp handle_delete(conn, {:error, _, reason, _}) do
    assign_error(conn, reason)
  end

  defp handle_delete(conn, {:error, reason}) do
    assign_error(conn, reason)
  end

  defp handle_delete(conn, {:ok, %{deleted_application: app}}) do
    assign(conn, :deleted_app, app)
  end
end
