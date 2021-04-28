defmodule Lenra.ClientAppMeasurementServices do
  @moduledoc """
    The service that manages the client's applications measurements.
  """
  require Logger

  alias Lenra.{Repo, ClientAppMeasurement}

  def get(id) do
    Repo.get(ClientAppMeasurement, id)
  end

  def get_by(clauses) do
    Repo.get_by(ClientAppMeasurement, clauses)
  end

  def create(user_id, params) do
    Repo.insert(ClientAppMeasurement.new(user_id, params))
  end
end
