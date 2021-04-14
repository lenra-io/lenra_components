defmodule Lenra.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  require Logger
  use Application

  def start(_type, _args) do
    Lenra.MigrationHelper.migrate()
    Lenra.Monitor.setup()

    children = [
      # Start the ecto repository
      Lenra.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lenra.PubSub},
      # Start guardian Sweeper to delete all expired tokens
      {Guardian.DB.Token.SweeperServer, []},
      # Start the Cache Storage system (init all tables of storage)
      LenraServers.Storage,
      # Start the json validator server for the UI
      UIValidator.JsonSchemata,
      # Start the Event Queue
      {EventQueue, &LenraServices.LoadWorker.load/0},
      # Start the HTTP Client
      {Finch, name: FaasHttp},
      AppChannelMonitor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lenra.Supervisor]

    Logger.info("Lenra Supervisor Starting")
    res = Supervisor.start_link(children, opts)
    Logger.info("Lenra Supervisor Started")
    res
  end
end
