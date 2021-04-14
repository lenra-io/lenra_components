defmodule Lenra.Repo do
  require Logger

  use Ecto.Repo,
    otp_app: :lenra,
    adapter: Ecto.Adapters.Postgres

  def migrate do
    Logger.info("Migrating...")

    path = Application.app_dir(:lenra, "priv/repo/migrations")

    Ecto.Migrator.run(Lenra.Repo, path, :up, all: true)
  end
end
