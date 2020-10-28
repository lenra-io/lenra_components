defmodule Lenra.MixProject do
  use Mix.Project

  def project do
    [
      app: :lenra,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      # releases
      releases: [
        lenra: [
          include_executables_for: [:unix],
        ]
      ],

      # Docs
      name: "Lenra Web Server"
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Lenra.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.4"},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:jiffy, "~> 1.0"},
      {:jason, "~> 1.2"},
      {:json_xema, "~> 0.6"},
      {:plug_cowboy, "~> 2.0"},
      {:finch, "~> 0.3"},
      {:json_diff, "~> 0.1.0"},
      {:cowlib, "~> 2.9.1", override: true},
      {:ranch, "~> 1.7.1", override: true},
      {:cors_plug, "~> 2.0"},
      {:bypass, "~> 2.0", only: :test},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.8", only: :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"]
    ]
  end
end
