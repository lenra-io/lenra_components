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
  ow_host: "http://localhost",
  ow_port: 1234,
  ow_auth:
    "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
