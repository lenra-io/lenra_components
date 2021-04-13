defmodule LenraServices.OpenfaasRunActionMeasurementServices do
  @moduledoc """
    The service that manages the openfaas measurements.
  """
  require Logger

  alias Lenra.OpenfaasRunActionMeasurement
  alias Lenra.Repo

  def get(id) do
    Repo.get(OpenfaasRunActionMeasurement, id)
  end

  def get_by(clauses) do
    Repo.get_by(OpenfaasRunActionMeasurement, clauses)
  end

  def create(user_id, params) do
    Repo.insert(OpenfaasRunActionMeasurement.new(user_id, params))
  end
end
