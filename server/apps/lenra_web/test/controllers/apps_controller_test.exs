defmodule LenraWeb.AppsControllerTest do
  use LenraWeb.ConnCase

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

    @tag :user_authentication
    test "apps controller authenticated", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.apps_path(conn, :create, %{
            "name" => "test",
            "service_name" => "test",
            "color" => "ffffff",
            "icon" => 31
          })
        )

      conn = get(conn, Routes.apps_path(conn, :index))

      assert %{
               "data" => %{
                 "apps" => [
                   %{
                     "name" => "test",
                     "service_name" => "test",
                     "color" => "ffffff",
                     "icon" => 31,
                     "id" => _
                   }
                 ]
               },
               "success" => true
             } = json_response(conn, 200)
    end
  end

  describe "create" do
    @tag :user_authentication
    test "apps controller authenticated", %{conn: conn} do
      route = Routes.apps_path(conn, :create)
      assert route == "/api/apps"

      conn =
        post(conn, route, %{
          "name" => "test",
          "service_name" => "test",
          "color" => "FFFFFF",
          "icon" => 1
        })

      {:ok, app} = Enum.fetch(Lenra.Repo.all(Lenra.LenraApplication), 0)

      assert %Lenra.LenraApplication{
               color: "FFFFFF",
               icon: 1,
               name: "test",
               service_name: "test"
             } = app

      assert app.creator_id == Guardian.Plug.current_resource(conn)
    end

    @tag :user_authentication
    test "apps controller authenticated but incorrect params", %{conn: conn} do
      conn =
        post(conn, Routes.apps_path(conn, :create), %{
          "name" => 1234,
          "service_name" => 1234,
          "color" => 1234,
          "icon" => "test"
        })

      assert %{"errors" => _} = json_response(conn, 400)
    end
  end

  describe "delete" do
    @tag :user_authentication
    test "apps controller authenticated", %{conn: conn} do
      conn =
        post(conn, Routes.apps_path(conn, :create), %{
          "name" => "test",
          "service_name" => "test",
          "color" => "FFFFFF",
          "icon" => 1
        })

      {:ok, app} = Enum.fetch(Lenra.Repo.all(Lenra.LenraApplication), 0)

      route = Routes.apps_path(conn, :delete, app.service_name)
      assert route == "/api/apps/#{app.service_name}"

      conn = delete(conn, route)

      assert %{"success" => true} == json_response(conn, 200)

      assert [] == Lenra.Repo.all(Lenra.LenraApplication)
    end

    @tag :user_authentication
    test "apps controller authenticated but app does not exist", %{conn: conn} do
      route = Routes.apps_path(conn, :delete, "test")

      conn = delete(conn, route)

      assert %{"errors" => [%{"code" => 404, "message" => "Not Found."}], "success" => false} ==
               json_response(conn, 404)
    end
  end
end
