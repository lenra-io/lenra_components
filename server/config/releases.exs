import Config

config :lenra, LenraWeb.Endpoint,
  http: [port: System.fetch_env!("PORT")],
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
  url: [host: {:system, "APP_HOST"}, port: {:system, "PORT"}]

config :lenra, Lenra.Repo,
  username: System.fetch_env!("POSTGRES_USER"),
  password: System.fetch_env!("POSTGRES_PASSWORD"),
  database: System.fetch_env!("POSTGRES_DB"),
  hostname: System.fetch_env!("POSTGRES_HOST")

config :lenra,
  faas_url: System.fetch_env!("FAAS_URL"),
  faas_auth: System.fetch_env!("FAAS_AUTH")

config :peerage, via: Peerage.Via.Dns,
  dns_name: System.fetch_env!("SERVICE_NAME"),
  app_name: "lenra"
