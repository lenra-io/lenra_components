defmodule LenraSchema.User do
  @moduledoc """
    The user shema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @email_regex ~r/[^@]+@[^\.]+\..+/

  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:password, :string)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :email, :password])
    |> validate_required([:email, :password, :first_name, :last_name])
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8, max: 64)
    |> put_pass_hash()
    |> validate_length(:first_name, min: 2, max: 256)
    |> validate_length(:last_name, min: 2, max: 256)
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password, hash_key: :password))
  end

  defp put_pass_hash(changeset), do: changeset
end
