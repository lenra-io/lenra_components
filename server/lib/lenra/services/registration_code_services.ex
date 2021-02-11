defmodule LenraServices.RegistrationCodeServices do
  @moduledoc """
    The user service.
  """

  alias Lenra.{RegistrationCode, User}

  @spec registration_code_changeset(%{user: User.t()}) :: Ecto.Changeset.t()
  def registration_code_changeset(%{user: %User{} = user}) do
    Ecto.build_assoc(user, :registration_code)
    |> RegistrationCode.changeset(%{code: generate_code()})
  end

  @spec check_valid_and_delete(User.t(), String.t()) :: any
  def check_valid_and_delete(%User{} = user, code) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:check_valide, &check_valid(&1, &2, user, code))
    |> Ecto.Multi.delete(:delete_registration_code, fn %{check_valide: registration_code} ->
      registration_code
    end)
    |> Ecto.Multi.update(:update_user, User.changeset(user, %{role: User.const_user_role()}))
  end

  defp check_valid(repo, _, %User{} = user, code) do
    user = repo.preload(user, :registration_code)

    if not is_nil(user.registration_code) and user.registration_code.code == code do
      {:ok, user.registration_code}
    else
      {:error, :no_such_registration_code}
    end
  end

  @chars "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.split("", trim: true)
  @code_length 8
  defp generate_code do
    Enum.reduce(1..@code_length, [], fn _i, acc ->
      [Enum.random(@chars) | acc]
    end)
    |> Enum.join("")
  end
end
