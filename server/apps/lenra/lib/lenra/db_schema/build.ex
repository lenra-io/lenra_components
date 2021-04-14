defmodule Lenra.Build do
  @moduledoc """
    The build schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Lenra.{User, Build, LenraApplication}

  schema "builds" do
    field(:commit_hash, :string)
    field(:build_number, :integer)
    field(:status, Ecto.Enum, values: [:pending, :error, :success])
    belongs_to(:creator, User)
    belongs_to(:application, LenraApplication)

    timestamps()
  end

  def changeset(build, params \\ %{}) do
    build
    |> cast(params, [:commit_hash, :status])
    |> validate_required([:commit_hash, :build_number, :status, :creator_id, :application_id])
    |> validate_inclusion(:status, [:pending, :error, :success])
    |> foreign_key_constraint(:creator_id)
    |> foreign_key_constraint(:application_id)
  end

  def update(build, params) do
    build
    |> changeset(params)
  end

  def new(creator_id, application_id, build_number, params) do
    %Build{creator_id: creator_id, application_id: application_id, build_number: build_number, status: :pending}
    |> Build.changeset(params)
  end
end
