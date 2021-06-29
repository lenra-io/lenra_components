defmodule LenraWeb.ApplicationRunnerAdapter do
  @moduledoc """
  ApplicationRunnerAdapter for LenraWeb
  Defining functions to communicate with OpenFaaS and get/save data to datastores
  """
  @behaviour ApplicationRunner.AdapterBehavior

  alias Lenra.Openfaas
  alias Lenra.{LenraApplicationServices, DatastoreServices}

  @impl ApplicationRunner.AdapterBehavior
  def run_action(client_id, app_name, build_number, action_code, body) do
    Openfaas.run_action(client_id, app_name, build_number, action_code, body)
  end

  @impl ApplicationRunner.AdapterBehavior
  def get_data({client_id, app_name}) do
    with {:ok, application} <-
           LenraApplicationServices.fetch_by([service_name: app_name], {:error, :no_such_application}) do
      DatastoreServices.get_datastore_data(client_id, application.id)
    end
  end

  @impl ApplicationRunner.AdapterBehavior
  def save_data({client_id, app_name}, data) do
    with {:ok, application} <-
           LenraApplicationServices.fetch_by([service_name: app_name], {:error, :no_such_application}) do
      DatastoreServices.upsert_data(client_id, application.id, data)
    end
  end
end
