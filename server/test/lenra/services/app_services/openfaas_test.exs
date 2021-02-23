defmodule LenraServers.OpenfaasTest do
  @moduledoc """
    Test the Errors for some routes
  """
  use ExUnit.Case, async: false

  alias LenraWeb.AppStub, as: AppStub

  @john_doe_application %Lenra.LenraApplication{
    image: "test",
    name: "test",
    env_process: "node index.js",
    color: "FFFFFF",
    icon: 1
  }

  describe "applist" do
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

      assert_raise(RuntimeError, "Openfaas error (404) Not Found", fn ->
        LenraServices.Openfaas.run_action("StubApp", "InitData", %{"toto" => "tata"})
      end)
    end
  end

  describe "deploy" do
    test "app but openfaas unreachable" do
      assert_raise(RuntimeError, "Openfaas could not be reached. It should not happen.", fn ->
        LenraServices.Openfaas.deploy_app(@john_doe_application)
      end)
    end

    test "app and openfaas reachable" do
      AppStub.create_faas_stub()
      |> AppStub.expect_deploy_app_once(%{"ok" => "200"})

      res = LenraServices.Openfaas.deploy_app(@john_doe_application)

      assert res == {:ok, 200}
    end
  end

  describe "delete" do
    test "app and openfaas reachable" do
      AppStub.create_faas_stub()
      |> AppStub.expect_delete_app_once(%{"ok" => "200"})

      res = LenraServices.Openfaas.delete_app_openfaas(@john_doe_application)

      assert res == {:ok, 200}
    end

    test "app but openfaas error 400" do
      AppStub.create_faas_stub()
      |> AppStub.expect_delete_app_once({:error, 400, "Bad request"})

      assert_raise(RuntimeError, "Openfaas could not delete the application. It should not happen.", fn ->
        LenraServices.Openfaas.delete_app_openfaas(@john_doe_application)
      end)
    end

    @tag capture_log: true
    test "app but openfaas error 404" do
      AppStub.create_faas_stub()
      |> AppStub.expect_delete_app_once({:error, 404, "Not found"})

      res = LenraServices.Openfaas.delete_app_openfaas(@john_doe_application)

      assert res == {:ok, 404}
    end
  end
end
