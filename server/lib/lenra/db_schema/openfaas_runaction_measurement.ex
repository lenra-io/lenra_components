defmodule Lenra.OpenfaasRunActionMeasurement do
  @moduledoc """
    The openfaas measurements schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Lenra.OpenfaasRunActionMeasurement

  schema "openfaas_runaction_measurements" do
    belongs_to(:user, Lenra.User)
    field(:application_name, :string)
    field(:duration, :integer)

    timestamps()
  end

  def changeset(measurements, params \\ %{}) do
    measurements
    |> cast(params, [:application_name, :duration])
    |> validate_required([:user_id, :application_name, :duration])
    |> foreign_key_constraint(:user_id)
  end

  def new(user_id, params) do
    %OpenfaasRunActionMeasurement{user_id: user_id}
    |> OpenfaasRunActionMeasurement.changeset(params)
  end
end
