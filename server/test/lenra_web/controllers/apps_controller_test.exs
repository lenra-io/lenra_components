defmodule LenraWeb.AppsControllerTest do
  use LenraWeb.ConnCase

  alias LenraWeb.AppStub

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  describe "index" do
    test "apps controller not authenticated", %{conn: conn} do
      conn = get(conn, Routes.apps_path(conn, :index))

      assert json_response(conn, 401) == %{
               "errors" => [%{"code" => 401, "message" => "You are not authenticated"}],
               "success" => false
             }
    end
  end

  describe "create" do
    @tag :user_authentication
    test "apps controller authenticated but no openfaas", %{conn: conn} do
      route = Routes.apps_path(conn, :create)
      assert route == "/api/apps"

      assert_raise(RuntimeError, "Openfaas could not be reached. It should not happen.", fn ->
        post(conn, Routes.apps_path(conn, :create), %{
          "image" => "test",
          "name" => "test",
          "env_process" => "node index.js",
          "color" => "FFFFFF",
          "icon" => 1
        })
      end)
    end

    @tag :user_authentication
    test "apps controller authenticated with openfaas", %{conn: conn} do
      AppStub.create_faas_stub()
      |> AppStub.expect_deploy_app_once(%{"ok" => "200"})

      conn =
        post(conn, Routes.apps_path(conn, :create), %{
          "image" => "test",
          "name" => "test",
          "env_process" => "node index.js",
          "color" => "FFFFFF",
          "icon" => 1
        })

      assert json_response(conn, 200) == %{"success" => true}
    end
  end
end
