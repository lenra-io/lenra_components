defmodule LenraServices.User do
  @moduledoc """
    The user service.
  """

  @doc """
    Register a new user, save him to the database. The email must be unique. The password is hashed before inserted to the database.
  """
  @spec sign_up(String.t(), String.t(), String.t(), String.t()) ::
          {:ok, LenraSchema.User} | {:error, String.t()}
  def sign_up(first_name, last_name, email, password) do
    %LenraSchema.User{}
    |> LenraSchema.User.changeset(%{
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password
    })
    |> Lenra.Repo.insert()
    |> case do
      {:ok, user} -> {:ok, delete_password_field(user)}
      res -> res
    end
  end

  @doc """
    check if the user exists in the database and compare the hashed password.
    Returns {:ok, user} if the email exists and password is correct.
    Otherwise, returns {:error, "Email or password incorrect."}
  """
  @spec sign_in(String.t(), String.t()) :: {:error, String.t()} | {:ok, LenraSchema.User}
  def sign_in(email, password) do
    LenraSchema.User
    |> Lenra.Repo.get_by(email: String.downcase(email))
    |> check_password(password)
  end

  defp check_password(nil, _), do: {:error, "Email or password incorrect."}

  defp check_password(user, password) do
    user
    |> Argon2.check_pass(password, hash_key: :password)
    |> case do
      {:error, _} -> {:error, "Email or password incorrect."}
      {:ok, user} -> {:ok, delete_password_field(user)}
    end
  end

  defp delete_password_field(user) do
    Map.delete(user, :password)
  end
end
