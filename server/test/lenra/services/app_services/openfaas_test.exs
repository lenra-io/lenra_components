defmodule LenraServers.OpenfaasTest do
  use ExUnit.Case, async: true

  alias LenraWeb.AppStub, as: AppStub

  @moduledoc """
    Test the Errors for some routes
  """

  setup do
    app = AppStub.create_faas_stub() |> AppStub.stub_app("StubApp")
    {:ok, app: app}
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
end
