defmodule LenraWeb.BuildsController do
  use LenraWeb, :controller

  def index(conn, params) do
    raw_build_list = LenraServices.BuildServices.all(params["app_id"])

    build_list =
      Enum.map(raw_build_list, fn build ->
        %{
          "id" => build.id,
          "commit_hash" => build.commit_hash,
          "build_number" => build.build_number,
          "status" => build.status,
          "creator_id" => build.creator_id,
          "application_id" => build.application_id
        }
      end)

    conn
    |> assign_data(:builds, build_list)
    |> reply
  end

  def update(conn, params) do
    build = LenraServices.BuildServices.get(params["id"])

    res = LenraServices.BuildServices.update(build, params)

    conn
    |> handle_update(res)
    |> reply
  end

  defp handle_update(conn, {:ok, %{updated_build: build}}) do
    assign(conn, :updated_build, build)
  end

  defp handle_update(conn, {:error, _, failed_value, _}) do
    assign_error(conn, failed_value)
  end

  def create(conn, params) do
    {app_id, _} = Integer.parse(params["app_id"])

    res =
      Guardian.Plug.current_resource(conn)
      |> LenraServices.BuildServices.create(app_id, params)

    conn
    |> handle_create(res)
    |> reply
  end

  defp handle_create(conn, {:error, _, failed_value, _}) do
    assign_error(conn, failed_value)
  end

  defp handle_create(conn, {:ok, %{inserted_build: build}}) do
    assign(conn, :inserted_build, build)
  end
end
