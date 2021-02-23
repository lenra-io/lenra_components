defmodule Lenra.LenraApplication do
  @moduledoc """
    The application schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @hex_regex ~r/[0-9A-Fa-f]{6}/

  schema "applications" do
    belongs_to(:user, Lenra.User)
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
end
