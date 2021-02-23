defmodule LenraWeb.AppsController do
  use LenraWeb, :controller
  require Logger

  alias Lenra.LenraApplication

  def index(conn, _params) do
    raw_app_list = Lenra.Repo.all(LenraApplication)
    app_list = Enum.map(raw_app_list, fn app -> %{"name" => app.name, "icon" => app.icon, "color" => app.color} end)

    conn
    |> assign_data(:apps, app_list)
    |> reply
  end

  def create(conn, params) do
    res =
      Guardian.Plug.current_resource(conn)
      |> Ecto.build_assoc(:applications)
      |> LenraApplication.changeset(params)
      |> LenraServices.ApplicationServices.register_app()
      |> Lenra.Repo.transaction()

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
      case Lenra.Repo.get_by(LenraApplication, name: app_name) do
        nil ->
          {:error, :error_404}

        app ->
          LenraServices.ApplicationServices.delete_app(app)
          |> Lenra.Repo.transaction()
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

  defp handle_delete(conn, {:ok, %{delete: app}}) do
    assign(conn, :deleted_app, app)
  end
end
