defmodule LenraWeb.UserController do
  use LenraWeb, :controller

  alias Lenra.Guardian.Plug
  alias LenraServices.{RegistrationCodeServices, TokenServices, UserServices}
  alias Lenra.{Repo, User}

  def register(conn, params) do
    res =
      %User{role: User.const_unvalidated_user_role()}
      |> User.changeset(params)
      |> UserServices.register()
      |> Lenra.Repo.transaction()

    conn
    |> handle_register(res)
    |> reply
  end

  defp handle_register(conn, {:error, _, failed_value, _}) do
    assign_error(conn, failed_value)
  end

  defp handle_register(conn, {:ok, %{user: user}}) do
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

  def check_registration_code(conn, params) do
    Plug.current_resource(conn)
    |> RegistrationCodeServices.check_valid_and_delete(params["code"])
    |> Repo.transaction()
    |> case do
      {:ok, %{update_user: updated_user}} ->
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
