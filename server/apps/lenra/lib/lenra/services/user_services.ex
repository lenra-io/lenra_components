defmodule Lenra.UserServices do
  @moduledoc """
    The user service.
  """
  import Ecto.Query, only: [from: 2]

  alias Lenra.{Repo, User, Password, EmailWorker, RegistrationCodeServices}

  @doc """
    Register a new user, save him to the database. The email must be unique. The password is hashed before inserted to the database.
  """
  def register(params, role \\ nil) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(
      :inserted_user,
      User.new(params, role)
    )
    |> Ecto.Multi.insert(
      :password,
      fn %{inserted_user: %User{} = user} -> Password.new(user, params) end
    )
    |> Ecto.Multi.insert(
      :inserted_registration_code,
      fn %{inserted_user: %User{} = user} ->
        RegistrationCodeServices.registration_code_changeset(user)
      end
    )
    |> Ecto.Multi.run(:add_event, &add_registration_events/2)
    |> Repo.transaction()
  end

  def get(id) do
    Repo.get(User, id)
  end

  defp add_registration_events(_repo, %{
         inserted_registration_code: registration_code,
         inserted_user: user
       }) do
    EmailWorker.add_email_verification_event(user, registration_code.code)
  end

  def update(user, params) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:updated_user, User.update(user, params))
  end

  def update_role(user, role) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:updated_user, User.change_role(user, role))
  end

  def validate_user(id, code) do
    user = get(id) |> Repo.preload(:registration_code)

    Ecto.Multi.new()
    |> Ecto.Multi.run(:check_valid, fn _, _ ->
      RegistrationCodeServices.check_valid(user.registration_code, code)
    end)
    |> Ecto.Multi.merge(fn _ -> RegistrationCodeServices.delete(user.registration_code) end)
    |> Ecto.Multi.merge(fn _ -> update_role(user, :user) end)
    |> Repo.transaction()
  end

  @doc """
    check if the user exists in the database and compare the hashed password.
    Returns {:ok, user} if the email exists and password is correct.
    Otherwise, returns {:error, :email_or_password_incorrect}
  """
  @spec login(binary(), binary()) :: {:ok, %User{}} | {:error, :email_or_password_incorrect}
  def login(email, password) do
    User
    |> Repo.get_by(email: String.downcase(email))
    |> check_password(password)
  end

  def check_password(%User{} = user, password) do
    user = Repo.preload(user, [password: from(p in Password, order_by: [desc: p.id])], force: true)

    user_password = user.password |> hd

    Argon2.verify_pass(password, user_password.password)
    |> case do
      false -> {:error, :email_or_password_incorrect}
      true -> {:ok, user}
    end
  end

  def check_password(_user, _password) do
    {:error, :email_or_password_incorrect}
  end
end
