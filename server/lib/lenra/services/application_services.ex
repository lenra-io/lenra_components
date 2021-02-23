defmodule LenraServices.ApplicationServices do
  @moduledoc """
    The service that manages registration and deletion of a lenra application in both database and openfaas.
  """
  require Logger
  alias LenraServices.Openfaas

  def register_app(app_changeset) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:application, app_changeset)
    |> Ecto.Multi.run(:openfaas_deploy, fn _repo, %{application: app} ->
      Openfaas.deploy_app(app)
    end)
  end

  def delete_app(%Lenra.LenraApplication{} = app) do
    Ecto.Multi.new()
    |> Ecto.Multi.delete(:delete, app)
    |> Ecto.Multi.run(:openfaas_delete, fn _repo, %{delete: app} ->
      Openfaas.delete_app_openfaas(app)
    end)
  end
end
