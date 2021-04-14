defmodule LenraWeb.EnvironmentControllerTest do
  use LenraWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  describe "index" do
    test "environment controller not authenticated", %{conn: conn} do
      conn = get(conn, Routes.envs_path(conn, :index, 0))

      assert json_response(conn, 401) == %{
               "errors" => [%{"code" => 401, "message" => "You are not authenticated"}],
               "success" => false
             }
    end

    @tag :user_authentication
    test "environment controller authenticated", %{conn: conn} do
      conn =
        post(conn, Routes.apps_path(conn, :create), %{
          "name" => "test",
          "service_name" => "test",
          "color" => "ffffff",
          "icon" => 12
        })

      {:ok, app} = Enum.fetch(Lenra.Repo.all(Lenra.LenraApplication), 0)

      conn =
        post(conn, Routes.envs_path(conn, :create, app.id), %{
          "name" => "test",
          "is_ephemeral" => false
        })

      assert nil != LenraServices.EnvironmentServices.get_by(name: "test")

      conn = get(conn, Routes.envs_path(conn, :index, app.id))

      assert %{
               "data" => %{
                 "envs" => [
                   %{
                     "is_ephemeral" => false,
                     "name" => "live",
                     "application_id" => _,
                     "creator_id" => _,
                     "deployed_build_id" => _,
                     "id" => _
                   },
                   %{
                     "is_ephemeral" => false,
                     "name" => "test",
                     "application_id" => _,
                     "creator_id" => _,
                     "deployed_build_id" => _,
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
    test "environment controller authenticated", %{conn: conn} do
      conn =
        post(conn, Routes.apps_path(conn, :create), %{
          "name" => "test",
          "service_name" => "test",
          "color" => "ffffff",
          "icon" => 12
        })

      {:ok, app} = Enum.fetch(Lenra.Repo.all(Lenra.LenraApplication), 0)

      post(conn, Routes.envs_path(conn, :create, app.id), %{
        "name" => "test",
        "is_ephemeral" => false
      })

      assert nil != LenraServices.EnvironmentServices.get_by(name: "test")
    end

    @tag :user_authentication
    test "environment controller authenticated but invalid params", %{conn: conn} do
      conn =
        post(conn, Routes.apps_path(conn, :create), %{
          "name" => "test",
          "service_name" => "test",
          "color" => "ffffff",
          "icon" => 12
        })

      {:ok, app} = Enum.fetch(Lenra.Repo.all(Lenra.LenraApplication), 0)

      conn =
        post(conn, Routes.envs_path(conn, :create, app.id), %{
          "name" => 1234,
          "is_ephemeral" => "false"
        })

      assert %{"errors" => _errors, "success" => false} = json_response(conn, 400)
    end
  end
end
