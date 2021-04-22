defmodule Lenra.LenraApplication do
  @moduledoc """
    The application schema.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Lenra.{User, Datastore, LenraApplication, Environment, Build}

  @hex_regex ~r/[0-9A-Fa-f]{6}/

  schema "applications" do
    field(:name, :string)
    field(:service_name, :string)
    field(:color, :string)
    field(:icon, :integer)

    belongs_to(:creator, User)
    has_many(:datastores, Datastore, foreign_key: :application_id)
    has_many(:environments, Environment, foreign_key: :application_id)
    has_many(:builds, Build, foreign_key: :application_id)
    timestamps()
  end

  def changeset(application, params \\ %{}) do
    application
    |> cast(params, [:name, :service_name, :color, :icon])
    |> validate_required([:name, :service_name, :color, :icon, :creator_id])
    |> unique_constraint(:name)
    |> validate_format(:color, @hex_regex)
    |> validate_length(:name, min: 2, max: 64)
    |> validate_length(:service_name, min: 2, max: 64)
  end

  def new(creator_id, params) do
    %LenraApplication{creator_id: creator_id}
    |> changeset(params)
  end

  def update(app, params) do
    app
    |> changeset(params)
  end
end