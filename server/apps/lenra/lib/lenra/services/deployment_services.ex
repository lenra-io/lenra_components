defmodule Lenra.DeploymentServices do
  @moduledoc """
    The service that manages the different possible actions on a deployment.
  """
  require Logger

  alias Lenra.{Repo, Deployment, BuildServices, EnvironmentServices, Openfaas}

  def get(deployment_id) do
    Repo.get(Deployment, deployment_id)
  end

  def get_by(clauses) do
    Repo.get_by(Deployment, clauses)
  end

  def create(environment_id, build_id, publisher_id, params \\ %{}) do
    build =
      BuildServices.get(build_id)
      |> Repo.preload(:application)

    env = EnvironmentServices.get(environment_id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:updated_env, Ecto.Changeset.change(env, deployed_build_id: build.id))
    |> Ecto.Multi.insert(
      :inserted_deployment,
      Deployment.new(build.application.id, environment_id, build_id, publisher_id, params)
    )
    |> Ecto.Multi.run(:openfaas_deploy, fn _repo, _ ->
      Openfaas.deploy_app(build.application.service_name, build.build_number)
    end)
    |> Repo.transaction()
  end

  def delete(deployment) do
    Ecto.Multi.new()
    |> Ecto.Multi.delete(:deleted_deployment, deployment)
  end
end
