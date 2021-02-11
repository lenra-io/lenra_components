defmodule Lenra.Repo do
  use Ecto.Repo,
    otp_app: :lenra,
    adapter: Ecto.Adapters.Postgres

  def migrate do
    IO.puts("Migrating...")

    path = Application.app_dir(:lenra, "priv/repo/migrations")

    Ecto.Migrator.run(Lenra.Repo, path, :up, all: true)
  end
end
