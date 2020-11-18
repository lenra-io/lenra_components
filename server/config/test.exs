use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lenra, LenraWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Used to "mock" with Bypass
config :lenra,
  faas_host: "http://localhost",
  faas_port: 1234,
  faas_auth: "Basic YWRtaW46M2kwREc4NTdLWlVaODQ3R0pheW5qMXAwbQ=="

config :lenra, Lenra.Repo,
  username: "postgres",
  password: "postgres",
  database: "lenra_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("POSTGRES_HOST", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox
