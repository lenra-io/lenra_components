defmodule LenraWeb.UserController do
  use LenraWeb, :controller

  alias Lenra.Guardian.Plug
  alias LenraServices.{TokenServices, UserServices}

  def register(conn, params) do
    UserServices.register(params)
    |> handle_register(conn)
    |> reply
  end

  defp handle_register({:error, _, failed_value, _}, conn) do
    assign_error(conn, failed_value)
  end

  defp handle_register({:ok, %{inserted_user: user}}, conn) do
    TokenServices.assign_access_and_refresh_token(conn, user)
  end

  def login(conn, params) do
    res = UserServices.login(params["email"], params["password"])

    conn
    |> handle_login(res)
    |> reply
  end

  defp handle_login(conn, {:error, reason}) do
    assign_error(conn, reason)
  end

  defp handle_login(conn, {:ok, user}) do
    TokenServices.assign_access_and_refresh_token(conn, user)
  end

  def refresh(conn, _params) do
    refresh_token = Plug.current_token(conn)
    access_token = TokenServices.create_access_token(refresh_token)

    conn
    |> TokenServices.assign_access_token(access_token)
    |> reply
  end

  def validate_user(conn, params) do
    user_id = Plug.current_resource(conn)

    UserServices.validate_user(user_id, params["code"])
    |> case do
      {:ok, %{updated_user: updated_user}} ->
        conn
        |> TokenServices.revoke_current_refresh()
        |> TokenServices.assign_access_and_refresh_token(updated_user)
        |> reply

      {:error, _, failed_value, _} ->
        conn
        |> assign_error(failed_value)
        |> reply
    end
  end

  def logout(conn, _params) do
    conn
    |> TokenServices.revoke_current_refresh()
    |> Plug.clear_remember_me()
    |> reply()
  end
end
