defmodule Lenra.MixProject do
  use Mix.Project

  def project do
    [
      app: :lenra,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Lenra.Application, []},
      extra_applications: [:logger, :runtime_tools, :guardian, :bamboo]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_pubsub, "~> 2.0"},
      {:ecto_sql, "~> 3.4"},
      {:postgrex, "~> 0.15.8"},
      {:jason, "~> 1.2"},
      {:json_diff, "~> 0.1.0"},
      {:guardian, "~> 2.1.1"},
      {:guardian_db, "~> 2.0"},
      {:finch, "~> 0.3"},
      {:argon2_elixir, "~> 2.0"},
      {:bamboo, "~> 1.7.1"},
      {:bamboo_smtp, "~> 3.1.3"},
      {:bypass, "~> 2.0", only: :test},
      {:ui_validator, in_umbrella: true},
      {:event_queue, in_umbrella: true}
    ]
  end
end