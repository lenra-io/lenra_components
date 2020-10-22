# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :lenra, LenraWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FuEn07fjnCLaC53BiDoBagPYdsv/S65QTfxWgusKP1BA5NiaFzXGYMHLZ6JAYxt1",
  render_errors: [view: LenraWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Lenra.PubSub,
  live_view: [signing_salt: "DVg2ybPd"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jiffy Nif for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
