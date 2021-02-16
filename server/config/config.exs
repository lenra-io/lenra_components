# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# This is the BASE config, loaded at build time and it will be override by other configs

# General application configuration
use Mix.Config

# Configure the repo
config :lenra,
  ecto_repos: [Lenra.Repo]

# Configure Guardian
config :lenra, Lenra.Guardian,
  issuer: "lenra",
  secret_key: "5oIBVh2Hauo3LT4knNFu29lX9DYu74SWZfjZzYn+gfr0aryxuYIdpjm8xd0qGGqK"

# Configure Guardian DB
config :guardian, Guardian.DB,
  repo: Lenra.Repo,
  schema_name: "guardian_tokens",
  token_types: ["refresh"],
  sweep_interval: 60

# Configure bamboo
config :lenra, Lenra.Mailer,
  hackney_opts: [
    recv_timeout: :timer.minutes(1),
    connect_timeout: :timer.minutes(1)
  ]

# Configures the endpoint
config :lenra, LenraWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: {:system, "PORT"}],
  render_errors: [view: LenraWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Lenra.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jiffy Nif for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure JSON validator
config :ex_json_schema,
       :remote_schema_resolver,
       {LenraServices.JsonValidator.SchemaLoader, :load_schema}

config :lenra,
  json_validator_schema: "../../../../../json_validator/"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
