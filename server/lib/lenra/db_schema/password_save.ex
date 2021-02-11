defmodule LenraSchema.PasswordSave do
  @moduledoc """
    The password_save shema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "password_save" do
    field(:user_id, :string)
    field(:password, :string)
    field(:password_old, :string)
    field(:password_old_old, :string)
  end

  def changeset(password_save, params \\ %{}) do
    password_save
    |> cast(params, [:user_id, :password, :password_old, :password_old_old])
    |> validate_required([:email, :password, :first_name, :last_name])
    |> unique_constraint(:user_id)
    |> validate_length(:password, min: 8, max: 64)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password, hash_key: :password))
  end

  defp put_pass_hash(changeset), do: changeset
end
