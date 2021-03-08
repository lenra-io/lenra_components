defmodule LenraServices.DatastoreServices do
  @moduledoc """
    The service that manages the different possible actions on a datastore.
  """
  require Logger

  @doc """
    Gets the datastore.

    Returns `nil` if the datastore does not exist.
    Returns a `Lenra.Datastore` if the datastore exists.
  """
  def get_by(clauses) do
    Lenra.Repo.get_by(Lenra.Datastore, clauses)
  end

  @doc """
    Gets the datastore data

    Returns `%{}` if the datastore does not exist.
    Returns a `map` if the datastore exists.
  """
  def get_datastore_data(user_id, application_id) do
    case get_by(user_id: user_id, application_id: application_id) do
      nil -> %{}
      datastore -> datastore.data
    end
  end

  @doc """
  Creates or updates the data in the corresponding datastore.

  Returns `{:ok, struct}` if the data was successfully inserted or updated.
  Returns `{:error, changeset}` if the data could not be inserted or updated.
  """
  def upsert_data(user_id, application_id, data) do
    Lenra.Datastore.new(user_id, application_id, data)
    |> Lenra.Repo.insert(
      on_conflict: [set: [data: data]],
      conflict_target: [:user_id, :application_id]
    )
  end
end
