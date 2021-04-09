defmodule LenraWeb.EnvsController do
  use LenraWeb, :controller

  def index(conn, params) do
    raw_env_list = LenraServices.EnvironmentServices.all(params["app_id"])

    env_list =
      Enum.map(raw_env_list, fn env ->
        %{
          "id" => env.id,
          "name" => env.name,
          "is_ephemeral" => env.is_ephemeral,
          "application_id" => env.application_id,
          "creator_id" => env.creator_id,
          "deployed_build_id" => env.deployed_build_id
        }
      end)

    conn
    |> assign_data(:envs, env_list)
    |> reply
  end

  def create(conn, params) do
    {app_id, _} = Integer.parse(params["app_id"])
    user_id = Guardian.Plug.current_resource(conn)

    res = LenraServices.EnvironmentServices.create(app_id, user_id, params)

    conn
    |> handle_create(res)
    |> reply
  end

  defp handle_create(conn, {:error, _, failed_value, _}) do
    assign_error(conn, failed_value)
  end

  defp handle_create(conn, {:ok, %{inserted_env: env}}) do
    assign(conn, :inserted_env, env)
  end
end
