defmodule LenraWeb.UserController do
  use LenraWeb, :controller

  alias Lenra.Guardian.Plug
  alias LenraServices.{UserServices, PasswordServices}
  alias LenraWeb.TokenHelper
  alias Lenra.{Repo, User}

  def register(conn, params) do
    conn
    |> handle_register(UserServices.register(params))
    |> reply
  end

  defp handle_register(conn, {:error, _, failed_value, _}) do
    assign_error(conn, failed_value)
  end

  defp handle_register(conn, {:ok, %{inserted_user: user}}) do
    TokenHelper.assign_access_and_refresh_token(conn, user)
  end

  def login(conn, params) do
    conn
    |> handle_login(UserServices.login(params["email"], params["password"]))
    |> reply
  end

  defp handle_login(conn, {:error, reason}) do
    assign_error(conn, reason)
  end

  defp handle_login(conn, {:ok, user}) do
    TokenHelper.assign_access_and_refresh_token(conn, user)
  end

  def refresh(conn, _params) do
    refresh_token = Plug.current_token(conn)
    access_token = TokenHelper.create_access_token(refresh_token)

    conn
    |> TokenHelper.assign_access_token(access_token)
    |> reply
  end

  def validate_user(conn, params) do
    user_id = Plug.current_resource(conn)

    UserServices.validate_user(user_id, params["code"])
    |> case do
      {:ok, %{updated_user: updated_user}} ->
        conn
        |> TokenHelper.revoke_current_refresh()
        |> TokenHelper.assign_access_and_refresh_token(updated_user)
        |> reply

      {:error, _, failed_value, _} ->
        conn
        |> assign_error(failed_value)
        |> reply
    end
  end

  def logout(conn, _params) do
    conn
    |> TokenHelper.revoke_current_refresh()
    |> Plug.clear_remember_me()
    |> reply()
  end

  def password_modification(conn, params) do
    Plug.current_resource(conn)
    |> PasswordServices.update_password(params)
    |> case do
      {:error, reason} ->
        conn
        |> assign_error(reason)
        |> reply()

      {:ok, _password} ->
        conn
        |> reply()
    end
  end

  defp handle_user_email(params) do
    case params["email"] do
      nil ->
        {:error, :email_incorrect}

      _ ->
        User
        |> Repo.get_by(email: String.downcase(params["email"]))
    end
  end

  def password_lost_modification(conn, params) do
    with %User{} = user <- handle_user_email(params),
         {:ok, _} <- PasswordServices.check_password_code_valid(user, params["code"]),
         {:ok, _password} <- PasswordServices.update_lost_password(user, params) do
      conn
      |> reply()
    else
      {:error, reason} ->
        conn
        |> assign_error(reason)
        |> reply()

      nil ->
        conn
        |> assign_error(:email_incorrect)
        |> reply()
    end
  end

  def password_lost_code(conn, params) do
    with %User{} = user <- handle_user_email(params),
         {:ok, _} <- PasswordServices.send_password_code(user) do
      conn
      |> reply
    else
      {:error, _, failed_value, _} ->
        conn
        |> assign_error(failed_value)
        |> reply

      {:error, failed_value} ->
        conn
        |> assign_error(failed_value)
        |> reply

      nil ->
        conn
        |> assign_error(:email_incorrect)
        |> reply()
    end
  end
end
