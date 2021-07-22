defmodule LenraWeb.MixProject do
  use Mix.Project

  def project do
    [
      app: :lenra_web,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {LenraWeb.Application, []},
      extra_applications: [:logger, :runtime_tools, :peerage]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.5.9"},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:plug_cowboy, "~> 2.0"},
      {:phoenix_ecto, "~> 4.1"},
      {:cors_plug, "~> 2.0"},
      {:sentry, "~> 8.0"},
      {:peerage, "~> 1.0"},
      {:lenra, in_umbrella: true},
      private_git(:bouncer, "gitlab.com", "lenra/platform/libs/bouncer.git", "0.2.0"),
      private_git(:application_runner, "gitlab.com", "lenra/platform/libs/application-runner.git", "0.5.0")
    ]
  end

  defp private_git(name, host, project, tag) do
    case System.get_env("CI") do
      "true" ->
        {name, git: "https://gitlab-ci-token:#{System.get_env("CI_JOB_TOKEN")}@#{host}/#{project}", tag: tag}

      _ ->
        {name, git: "git@#{host}:#{project}", tag: tag}
    end
  end
end
