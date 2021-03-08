defmodule LenraServices.UserServices do
  @moduledoc """
    The user service.
  """

  alias Lenra.{Repo, User}
  alias LenraServices.{RegistrationCodeServices, UserServices}

  alias LenraServices.EmailWorker

  @doc """
    Register a new user, save him to the database. The email must be unique. The password is hashed before inserted to the database.
  """
  def register(params) do
    Ecto.Multi.new()
    |> Ecto.Multi.merge(fn _ -> UserServices.create(params) end)
    |> Ecto.Multi.merge(fn %{inserted_user: user} -> RegistrationCodeServices.create(user) end)
    |> Ecto.Multi.run(:add_event, fn _repo, %{inserted_registration_code: registration_code, inserted_user: user} ->
      EmailWorker.add_email_verification_event(user, registration_code.code)
    end)
    |> Repo.transaction()
  end

  def get(id) do
    Repo.get(User, id)
  end

  def create(params) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:inserted_user, User.new(params))
  end

  def update(user, params) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:updated_user, User.update(user, params))
  end

  @spec validate_user(any, String.t()) :: Ecto.Multi.t()
  def validate_user(id, code) do
    user = UserServices.get(id) |> Repo.preload(:registration_code)

    Ecto.Multi.new()
    |> Ecto.Multi.run(:check_valid, fn _, _ -> RegistrationCodeServices.check_valid(user.registration_code, code) end)
    |> Ecto.Multi.merge(fn _ -> RegistrationCodeServices.delete(user.registration_code) end)
    |> Ecto.Multi.merge(fn _ -> UserServices.update(user, %{role: User.const_user_role()}) end)
    |> Lenra.Repo.transaction()
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
