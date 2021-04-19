defmodule Lenra.User do
  @moduledoc """
    The user shema.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Lenra.User

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
    has_many(:password, Lenra.Password)
    field(:role, :integer)
    has_one(:registration_code, Lenra.RegistrationCode)
    has_many(:applications, Lenra.LenraApplication, foreign_key: :creator_id)
    has_many(:datastores, Lenra.Datastore)
    has_one(:password_code, Lenra.PasswordCode)
    has_many(:builds, Lenra.Build, foreign_key: :creator_id)
    has_many(:environments, Lenra.Environment, foreign_key: :creator_id)
    has_many(:deployments, Lenra.Deployment, foreign_key: :publisher_id)
    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :email, :role])
    |> validate_required([:email, :first_name, :last_name, :role])
    |> validate_length(:first_name, min: 2, max: 256)
    |> validate_length(:last_name, min: 2, max: 256)
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)
    |> validate_inclusion(:role, @all_roles)
  end

  def new(user_schema, params) do
    user_schema
    |> changeset(params)
  end

  def update(%User{} = user, params) do
    changeset(user, params)
  end
end
