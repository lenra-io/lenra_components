defmodule LenraWeb.Router do
  use LenraWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :ensure_auth do
    plug Lenra.Guardian.EnsureAuthenticatedPipeline
  end

  pipeline :ensure_auth_refresh do
    plug Lenra.Guardian.RefreshPipeline
  end

  scope "/auth", LenraWeb do
    pipe_through :api
    post "/register", UserController, :register
    post "/login", UserController, :login

    pipe_through :ensure_auth_refresh
    post "/refresh", UserController, :refresh
    post "/logout", UserController, :logout
    post "/verify", UserController, :check_registration_code
  end

  scope "/api", LenraWeb do
    pipe_through [:api, :ensure_auth]
    resources "/apps", AppsController, only: [:index, :create, :delete]
  end

  scope "/", LenraWeb do
    get("/health", HealthController, :index)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: LenraWeb.Telemetry
    end
  end
end
