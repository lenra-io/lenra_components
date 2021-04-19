defmodule Lenra.Password do
  @moduledoc """
    The password_save shema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "passwords" do
    belongs_to(:user, Lenra.User)
    field(:password, :string, redact: true)
    timestamps()
  end

  def changeset(password, params \\ %{}) do
    password
    |> cast(params, [:password])
    |> validate_required([:password, :user_id])
    |> unique_constraint(:password)
    |> validate_length(:password, min: 8, max: 64)
    |> validate_confirmation(:password)
    |> put_pass_hash()
  end

  def new(user, params) do
    Ecto.build_assoc(user, :password)
    |> changeset(params)
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password, hash_key: :password))
  end
end
