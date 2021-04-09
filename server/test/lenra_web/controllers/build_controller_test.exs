defmodule LenraWeb.BuildControllerTest do
  use LenraWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  defp create_app_and_build(conn) do
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

    %{conn: conn, app: app}
  end

  describe "index" do
    test "build controller not authenticated", %{conn: conn} do
      conn = get(conn, Routes.builds_path(conn, :index, 0))

      assert json_response(conn, 401) == %{
               "errors" => [%{"code" => 401, "message" => "You are not authenticated"}],
               "success" => false
             }
    end

    @tag :user_authentication
    test "build controller authenticated", %{conn: conn} do
      %{conn: conn, app: app} = create_app_and_build(conn)

      conn = get(conn, Routes.builds_path(conn, :index, app.id))

      assert %{
               "data" => %{
                 "builds" => [
                   %{
                     "build_number" => 1,
                     "commit_hash" => "test",
                     "status" => "pending",
                     "application_id" => _,
                     "creator_id" => _,
                     "id" => _
                   }
                 ]
               },
               "success" => true
             } = json_response(conn, 200)
    end
  end

  describe "update" do
    @tag :user_authentication
    test "build controller authenticated", %{conn: conn} do
      %{conn: conn, app: app} = create_app_and_build(conn)
      build = LenraServices.BuildServices.get_by(application_id: app.id)

      patch(conn, Routes.builds_path(conn, :update, app.id, build.id), %{status: :success})

      assert :success == LenraServices.BuildServices.get(build.id).status
    end
  end

  describe "create" do
    @tag :user_authentication
    test "build controller authenticated", %{conn: conn} do
      create_app_and_build(conn)

      assert [] != Lenra.Repo.all(Lenra.Build)
    end

    @tag :user_authentication
    test "build controller authenticated check build_number incremented", %{conn: conn} do
      %{conn: conn, app: app} = create_app_and_build(conn)

      post(
        conn,
        Routes.builds_path(
          conn,
          :create,
          app.id
        ),
        %{
          "commit_hash" => "test2"
        }
      )

      assert nil != LenraServices.BuildServices.get_by(build_number: 2)

      assert [] != Lenra.Repo.all(Lenra.Build)
    end

    @tag :user_authentication
    test "build controller authenticated but invalid params", %{conn: conn} do
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
            "commit_hash" => 1234
          }
        )

      assert [] == Lenra.Repo.all(Lenra.Build)

      assert %{
               "errors" => [
                 %{"code" => 0, "message" => "commit_hash : is invalid"}
               ],
               "success" => false
             } == json_response(conn, 400)
    end
  end
end
