defmodule Lenra.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the ecto repository
      Lenra.Repo,
      # Start the Telemetry supervisor
      LenraWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lenra.PubSub},
      # Start the Endpoint (http/https)
      LenraWeb.Endpoint,
      # Start a worker by calling: Lenra.Worker.start_link(arg)
      # {Lenra.Worker, arg}
      # Start the Cache Storage system (init all tables of storage)
      LenraServers.Storage,
      {Finch, name: FaasHttp}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lenra.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LenraWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
