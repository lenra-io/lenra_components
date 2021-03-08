defmodule LenraServices.LenraApplicationServices do
  @moduledoc """
    The service that manages registration and deletion of a lenra application in both database and openfaas.
  """
  require Logger
  alias LenraServices.{LenraApplicationServices, Openfaas}
  alias Lenra.LenraApplication
  alias Lenra.{Repo, LenraApplication}

  def get(app_id) do
    Repo.get(LenraApplication, app_id)
  end

  def get_by(clauses) do
    Repo.get_by(LenraApplication, clauses)
  end

  def create(user_id, params) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:inserted_application, LenraApplication.new(user_id, params))
  end

  def delete(app) do
    Ecto.Multi.new()
    |> Ecto.Multi.delete(:deleted_application, app)
  end

  def create_and_deploy(user_id, params) do
    Ecto.Multi.new()
    |> Ecto.Multi.merge(fn _ -> LenraApplicationServices.create(user_id, params) end)
    |> Ecto.Multi.run(:openfaas_deploy, fn _repo, %{inserted_application: app} ->
      Openfaas.deploy_app(app)
    end)
    |> Lenra.Repo.transaction()
  end

  def delete_and_undeploy(app) do
    Ecto.Multi.new()
    |> Ecto.Multi.merge(fn _ -> LenraApplicationServices.delete(app) end)
    |> Ecto.Multi.run(:openfaas_delete, fn _repo, %{deleted_application: app} ->
      Openfaas.delete_app_openfaas(app)
    end)
    |> Lenra.Repo.transaction()
  end
end
