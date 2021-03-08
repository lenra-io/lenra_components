defmodule Lenra.LenraApplication do
  @moduledoc """
    The application schema.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Lenra.{User, Datastore, LenraApplication}

  @hex_regex ~r/[0-9A-Fa-f]{6}/

  schema "applications" do
    belongs_to(:user, User)
    has_many(:datastores, Datastore, foreign_key: :application_id)
    field(:image, :string)
    field(:name, :string)
    field(:env_process, :string)
    field(:color, :string)
    field(:icon, :integer)
    timestamps()
  end

  def changeset(application, params \\ %{}) do
    application
    |> cast(params, [:image, :name, :env_process, :color, :icon])
    |> validate_required([:image, :name, :env_process, :color, :icon])
    |> unique_constraint(:name)
    |> validate_format(:color, @hex_regex)
  end

  def new(user_id, params) do
    %LenraApplication{user_id: user_id}
    |> changeset(params)
  end
end
