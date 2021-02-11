defmodule Lenra.User do
  @moduledoc """
    The user shema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @email_regex ~r/[^@]+@[^\.]+\..+/

  @not_validated_user_role 1
  @user_role 2
  @admin_role 64
  @all_roles [@not_validated_user_role, @user_role, @admin_role]

  def const_unvalidated_user_role, do: 1
  def const_user_role, do: 2
  def const_admin_role, do: 64

  def const_list_all_roles,
    do: [const_unvalidated_user_role(), const_user_role(), const_admin_role()]

  @derive {Jason.Encoder, only: [:first_name, :last_name, :email]}
  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:password, :string, redact: true)
    field(:role, :integer)
    has_one(:registration_code, Lenra.RegistrationCode)
    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :email, :password, :role])
    |> validate_required([:email, :password, :first_name, :last_name, :role])
    |> validate_length(:first_name, min: 2, max: 256)
    |> validate_length(:last_name, min: 2, max: 256)
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8, max: 64)
    |> validate_confirmation(:password)
    |> validate_inclusion(:role, @all_roles)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password, hash_key: :password))
  end

  defp put_pass_hash(changeset), do: changeset
end
