defmodule LenraServers.OpenfaasTest do
  use ExUnit.Case, async: true

  alias LenraWeb.AppStub, as: AppStub

  @moduledoc """
    Test the Errors for some routes
  """

  setup do
    faas = AppStub.create_faas_stub()
    app = AppStub.stub_app(faas, "StubApp")
    {:ok, %{app: app, faas: faas}}
  end

  test "Openfaas correctly handle ok 200 and decode data", %{app: app} do
    AppStub.stub_action_once(app, "InitData", %{"data" => "any data"})

    assert {:ok, %{"data" => "any data"}} ==
             LenraServices.Openfaas.run_action("StubApp", "InitData", %{"toto" => "tata"})
  end

  test "Openfaas correctly handle 404 not found", %{app: app} do
    AppStub.stub_action_once(app, "InitData", {:error, 404, "Not Found"})

    assert {:error, "Error (404) Not Found"} ==
             LenraServices.Openfaas.run_action("StubApp", "InitData", %{"toto" => "tata"})
  end

  test "Openfaas correctly handle 200 OK for app list", %{faas: faas} do
    app_list = [%{"name" => "Counter"}, %{"name" => "MineSweeper"}]
    AppStub.expect_app_list_once(faas, app_list)

    assert {:ok, app_list} ==
             LenraServices.Openfaas.fetch_app_list()
  end

  test "Openfaas correctly handle 404 not found for app list", %{faas: faas} do
    app_list = {:error, 404, "Not Found"}
    AppStub.expect_app_list_once(faas, app_list)

    assert {:error, "Error (404) Not Found"} ==
             LenraServices.Openfaas.fetch_app_list()
  end
end
