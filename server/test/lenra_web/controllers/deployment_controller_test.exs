defmodule LenraWeb.DeploymentControllerTest do
  use LenraWeb.ConnCase

  alias LenraWeb.AppStub

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  describe "create" do
    @tag :user_authentication
    test "deployment controller authenticated", %{conn: conn} do
      AppStub.create_faas_stub()
      |> AppStub.expect_deploy_app_once(%{"ok" => "200"})

      conn =
        post(conn, Routes.apps_path(conn, :create), %{
          "name" => "test",
          "service_name" => "test",
          "color" => "ffffff",
          "icon" => 12
        })

      {:ok, app} = Enum.fetch(Lenra.Repo.all(Lenra.LenraApplication), 0)

      conn =
        post(
          conn,
          Routes.builds_path(
            conn,
            :create,
            app.id
          ),
          %{
            "commit_hash" => "test"
          }
        )

      env = Enum.at(Lenra.Repo.all(Lenra.Environment), 0)
      build = Enum.at(Lenra.Repo.all(Lenra.Build), 0)

      conn =
        post(conn, Routes.deployments_path(conn, :create), %{
          environment_id: env.id,
          build_id: build.id,
          application_id: app.id
        })

      assert [] != Lenra.Repo.all(Lenra.Deployment)

      assert %{"success" => true} == json_response(conn, 200)
    end

    @tag :user_authentication
    test "deployment controller but wrong environment", %{conn: conn} do
      conn =
        post(conn, Routes.apps_path(conn, :create), %{
          "name" => "test",
          "service_name" => "test",
          "color" => "ffffff",
          "icon" => 12
        })

      conn =
        post(conn, Routes.apps_path(conn, :create), %{
          "name" => "testtest",
          "service_name" => "testtest",
          "color" => "ffffff",
          "icon" => 12
        })

      app = LenraServices.LenraApplicationServices.get_by(name: "test")

      conn =
        post(
          conn,
          Routes.builds_path(
            conn,
            :create,
            app.id
          ),
          %{
            "commit_hash" => "test"
          }
        )

      wrong_app = LenraServices.LenraApplicationServices.get_by(name: "testtest")
      wrong_env = LenraServices.EnvironmentServices.get_by(application_id: wrong_app.id)
      build = LenraServices.BuildServices.get_by(commit_hash: "test")

      conn =
        post(conn, Routes.deployments_path(conn, :create), %{
          environment_id: wrong_env.id,
          build_id: build.id,
          application_id: app.id
        })

      assert %{"errors" => [%{"code" => 0, "message" => "environment_id : does not exist"}], "success" => false} ==
               json_response(conn, 400)
    end
  end
end
