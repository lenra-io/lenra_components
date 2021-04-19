defmodule LenraServices.PasswordServices do
  @moduledoc """
    The password service.
  """
  import Ecto.Query, only: [from: 2]

  alias Lenra.{Repo, User, Password, PasswordCode}
  alias LenraServices.{UserServices, RegistrationCodeServices, EmailWorker}

  @doc """
    Create a new password.
  """

  # def create_password(%User{} = user, params) do
  #  Ecto.build_assoc(user, :password)
  #  |> Password.changeset(%{
  #    password: params["password"],
  #    password_confirmation: params["password_confirmation"]
  #  })
  # end

  def update_password(
        user_id,
        params
      ) do
    user_loaded = UserServices.get(user_id) |> Repo.preload(:password)

    with {:ok, _user} <- UserServices.check_password(user_loaded, params["old_password"]),
         {:ok, _user} <- check_old_password(user_loaded, params) do
      Repo.insert(Password.new(user_loaded, params))
    else
      {:error, reason} -> {:error, reason}
      true -> {:error, :password_already_used}
    end
  end

  def update_lost_password(
        %User{} = user,
        params
      ) do
    user_loaded = Repo.preload(user, :password)

    case check_old_password(user_loaded, params) do
      {:ok, _user} -> Repo.insert(Password.new(user_loaded, params))
      {:error, reason} -> {:error, reason}
    end
  end

  defp check_old_password(user, params) do
    password =
      Repo.all(
        from(u in User,
          join: p in assoc(u, :password),
          where: u.id == ^user.id,
          order_by: [desc: p.inserted_at],
          limit: 3,
          select: p
        )
      )

    password
    |> Enum.any?(fn x ->
      Argon2.verify_pass(params["password"], x.password)
    end)
    |> case do
      true -> {:error, :password_already_used}
      false -> {:ok, user}
    end
  end

  @doc """
    Create a new password_code, save him to the database and send him to user by email.
  """
  def send_password_code(%User{} = user) do
    code = RegistrationCodeServices.generate_code()

    Ecto.Multi.new()
    |> Ecto.Multi.insert(
      :password_code,
      PasswordCode.new(user, code),
      conflict_target: :user_id,
      on_conflict: [set: [code: code]]
    )
    |> Ecto.Multi.run(:add_password_event, fn _repo, %{password_code: %PasswordCode{} = password_code} ->
      add_password_events(password_code, user)
    end)
    |> Repo.transaction()
  end

  defp add_password_events(password_code, user) do
    EmailWorker.add_email_password_lost_event(user, password_code.code)
  end

  def check_password_code_valid(%User{} = user, code) do
    password_code =
      Repo.all(
        from(u in User,
          join: p in assoc(u, :password_code),
          where: p.code == ^code,
          select: p
        )
      )

    with true <- not is_nil(List.first(password_code)),
         true <- date_difference(password_code) do
      {:ok, user}
    else
      false -> {:error, :no_such_password_code}
    end
  end

  @validity_time 3600
  def date_difference([password_code | _tail]) do
    if NaiveDateTime.diff(NaiveDateTime.utc_now(), password_code.inserted_at) <= @validity_time and
         NaiveDateTime.diff(NaiveDateTime.utc_now(), password_code.inserted_at) >= 0 do
      true
    else
      false
    end
  end
end
