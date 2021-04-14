defmodule LenraServices.DeploymentServices do
  @moduledoc """
    The service that manages the different possible actions on a deployment.
  """
  require Logger

  def get(deployment_id) do
    Lenra.Repo.get(Lenra.Deployment, deployment_id)
  end

  def get_by(clauses) do
    Lenra.Repo.get_by(Lenra.Deployment, clauses)
  end

  def create(environment_id, build_id, publisher_id, params \\ %{}) do
    build =
      LenraServices.BuildServices.get(build_id)
      |> Lenra.Repo.preload(:application)

    env = LenraServices.EnvironmentServices.get(environment_id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:updated_env, Ecto.Changeset.change(env, deployed_build_id: build.id))
    |> Ecto.Multi.insert(
      :inserted_deployment,
      Lenra.Deployment.new(build.application.id, environment_id, build_id, publisher_id, params)
    )
    |> Ecto.Multi.run(:openfaas_deploy, fn _repo, _ ->
      LenraServices.Openfaas.deploy_app(build.application.service_name, build.build_number)
    end)
    |> Lenra.Repo.transaction()
  end

  def delete(deployment) do
    Ecto.Multi.new()
    |> Ecto.Multi.delete(:deleted_deployment, deployment)
  end
end
