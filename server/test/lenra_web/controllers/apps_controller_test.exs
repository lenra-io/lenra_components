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
               "errors" => [%{"code" => 401, "message" => "You are not authenticated"}]
             }
    end

    @tag :user_authentication
    test "app controller authenticated but no openfaas", %{conn: conn} do
      route = Routes.apps_path(conn, :index)
      assert route == "/api/apps"
      conn = get(conn, Routes.apps_path(conn, :index))

      assert json_response(conn, 200) == %{
               "errors" => [%{"code" => 1000, "message" => "Openfaas is not accessible"}]
             }
    end

    @app_list [%{"name" => "myApp1"}, %{"name" => "myApp2"}]
    @tag :user_authentication
    test "app controller authenticated with openfaas", %{conn: conn} do
      AppStub.create_faas_stub()
      |> AppStub.expect_app_list_once(@app_list)

      conn = get(conn, Routes.apps_path(conn, :index))

      assert json_response(conn, 200) == %{"data" => %{"apps" => @app_list}, "ok" => "200"}
    end
  end
end
