defmodule Lenra.BuildServices do
  @moduledoc """
    The service that manages the different possible actions on a build.
  """
  require Logger

  import Ecto.Query

  alias Lenra.{Repo, Build}

  def all(app_id) do
    Repo.all(from(b in Build, where: b.application_id == ^app_id))
  end

  def get(build_id) do
    Repo.get(Build, build_id)
  end

  def fetch(build_id) do
    Repo.fetch(Build, build_id)
  end

  def fetch_by(clauses) do
    Repo.fetch_by(Build, clauses)
  end

  def create(creator_id, app_id, params) do
    build_number =
      Repo.one(from(b in Build, select: (max(b.build_number) |> coalesce(0)) + 1, where: b.application_id == ^app_id))

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:inserted_build, Build.new(creator_id, app_id, build_number, params))
    |> Repo.transaction()
  end

  def update(build, params) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:updated_build, Build.update(build, params))
    |> Repo.transaction()
  end

  def delete(build) do
    Ecto.Multi.new()
    |> Ecto.Multi.delete(:deleted_build, build)
  end
end
