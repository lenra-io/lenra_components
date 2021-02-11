defmodule LenraServices.UserServices do
  @moduledoc """
    The user service.
  """

  alias Lenra.{Repo, User}
  alias LenraServices.RegistrationCodeServices

  alias LenraServices.EmailWorker

  @doc """
    Register a new user, save him to the database. The email must be unique. The password is hashed before inserted to the database.
  """
  def register(user_changeset) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:user, user_changeset)
    |> Ecto.Multi.insert(
      :registration_code,
      &RegistrationCodeServices.registration_code_changeset/1
    )
    |> Ecto.Multi.run(:add_event, &add_registration_events/2)
  end

  defp add_registration_events(_repo, %{registration_code: registration_code, user: user}) do
    EmailWorker.add_email_verification_event(user, registration_code.code)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def update_user(user_changeset) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:update_user, user_changeset)
  end

  @doc """
    check if the user exists in the database and compare the hashed password.
    Returns {:ok, user} if the email exists and password is correct.
    Otherwise, returns {:error, :email_or_password_incorrect}
  """
  @spec login(binary(), binary()) ::
          {:ok, map()} | {:error, :email_or_password_incorrect}
  def login(email, password) do
    User
    |> Repo.get_by(email: String.downcase(email))
    |> Argon2.check_pass(password, hash_key: :password)
    |> case do
      {:error, _} -> {:error, :email_or_password_incorrect}
      okres -> okres
    end
  end
end
