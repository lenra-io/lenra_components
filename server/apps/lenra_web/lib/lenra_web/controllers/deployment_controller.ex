defmodule LenraWeb.DeploymentsController do
  use LenraWeb, :controller

  def create(conn, params) do
    publisher_id = Guardian.Plug.current_resource(conn)

    res = LenraServices.DeploymentServices.create(params["environment_id"], params["build_id"], publisher_id, params)

    conn
    |> handle_create(res)
    |> reply
  end

  defp handle_create(conn, {:ok, %{inserted_deployment: deployment}}) do
    assign(conn, :inserted_deployment, deployment)
  end

  defp handle_create(conn, {:error, _, failed_value, _}) do
    assign_error(conn, failed_value)
  end
end
