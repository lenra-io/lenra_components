defmodule Lenra.LenraApplicationServices do
  @moduledoc """
    The service that manages possible actions on a lenra application.
  """
  require Logger
  alias Lenra.{Repo, LenraApplication, Environment, ApplicationMainEnv}

  def all do
    Repo.all(LenraApplication)
  end

  def fetch(app_id) do
    Repo.fetch(LenraApplication, app_id)
  end

  def fetch_by(clauses) do
    Repo.fetch_by(LenraApplication, clauses)
  end

  def create(user_id, params) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:inserted_application, LenraApplication.new(user_id, params))
    |> Ecto.Multi.insert(:inserted_main_env, fn %{inserted_application: app} ->
      Environment.new(app.id, user_id, nil, %{name: "live", is_ephemeral: false})
    end)
    |> Ecto.Multi.insert(:application_main_env, fn %{inserted_application: app, inserted_main_env: env} ->
      ApplicationMainEnv.new(app.id, env.id)
    end)
    |> Repo.transaction()
  end

  def delete(app) do
    Ecto.Multi.new()
    |> Ecto.Multi.delete(:deleted_application, app)
    |> Repo.transaction()
  end
end
