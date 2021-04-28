defmodule Lenra.Repo do
  require Logger

  use Ecto.Repo,
    otp_app: :lenra,
    adapter: Ecto.Adapters.Postgres

  alias Lenra.Repo

  def migrate do
    Logger.info("Migrating...")

    path = Application.app_dir(:lenra, "priv/repo/migrations")

    Ecto.Migrator.run(Repo, path, :up, all: true)
  end

  def fetch(query, id) do
    case Repo.get(query, id) do
      nil -> {:error, :error_404}
      res -> {:ok, res}
    end
  end

  def fetch_by(query, args) do
    case Repo.get_by(query, args) do
      nil -> {:error, :error_404}
      res -> {:ok, res}
    end
  end
end
