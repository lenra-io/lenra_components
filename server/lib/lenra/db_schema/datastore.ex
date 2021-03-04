defmodule Lenra.Datastore do
  @moduledoc """
    The datastore schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "datastores" do
    belongs_to(:user, Lenra.User)
    belongs_to(:application, Lenra.LenraApplication)
    field(:data, :map)
    timestamps()
  end

  def changeset(datastore, params \\ %{}) do
    datastore
    |> cast(params, [:data])
    |> validate_required([:data])
    |> unique_constraint(:user_application_unique, name: :datastores_user_id_application_id_index)
  end

  def new(user_id, application_id, params) do
    %Lenra.Datastore{}
    |> Ecto.Changeset.cast(%{user_id: user_id, application_id: application_id}, [:user_id, :application_id])
    |> Lenra.Datastore.changeset(%{"data" => params})
  end
end
