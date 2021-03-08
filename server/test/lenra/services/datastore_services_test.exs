defmodule LenraServers.DatastoreServicesTest do
  use ExUnit.Case
  use Lenra.RepoCase

  alias LenraWeb.AppStub, as: AppStub
  alias LenraServices.{DatastoreServices, LenraApplicationServices}

  @moduledoc """
    Test the datastore services
  """

  setup do
    {:ok, app: create_and_return_application()}
  end

  defp create_and_return_application do
    {:ok, %{inserted_user: user}} = UserTestHelper.register_john_doe()

    AppStub.create_faas_stub()
    |> AppStub.expect_deploy_app_once(%{"ok" => "200"})

    LenraApplicationServices.create_and_deploy(user.id, %{
      image: "test",
      name: "mine-sweeper",
      env_process: "node index.js",
      color: "FFFFFF",
      icon: "60189"
    })

    Enum.at(Lenra.Repo.all(Lenra.LenraApplication), 0)
  end

  describe "get" do
    test "data from datastore but datastore does not exist", %{app: app} do
      assert %{} = DatastoreServices.get_datastore_data(app.user_id, app.id)
    end

    test "data from existing datastore", %{app: app} do
      DatastoreServices.upsert_data(app.user_id, app.id, %{"data" => "test data"})
      assert %{"data" => "test data"} == DatastoreServices.get_datastore_data(app.user_id, app.id)
    end

    test "datastore", %{app: app} do
      DatastoreServices.upsert_data(app.user_id, app.id, %{"data" => "test data"})

      assert (%Lenra.Datastore{} = datastore) = DatastoreServices.get_by(user_id: app.user_id, application_id: app.id)
      assert datastore.user_id == app.user_id
      assert datastore.application_id == app.id
      assert datastore.data == %{"data" => "test data"}
    end

    test "datastore but does not exist", %{app: app} do
      assert nil == DatastoreServices.get_by(user_id: app.user_id, application_id: app.id)
    end
  end

  describe "insert" do
    test "data", %{app: app} do
      assert {:ok,
              %Lenra.Datastore{
                data: %{"data" => "test data"}
              }} = DatastoreServices.upsert_data(app.user_id, app.id, %{"data" => "test data"})

      assert (%Lenra.Datastore{} = datastore) =
               Lenra.Repo.get_by(Lenra.Datastore, user_id: app.user_id, application_id: app.id)

      assert datastore.data == %{"data" => "test data"}
    end

    test "and check updated data", %{app: app} do
      DatastoreServices.upsert_data(app.user_id, app.id, %{"data" => "test data"})

      assert {:ok, %Lenra.Datastore{data: %{"data" => "test new data"}}} =
               DatastoreServices.upsert_data(app.user_id, app.id, %{"data" => "test new data"})

      assert (%Lenra.Datastore{} = datastore) =
               Lenra.Repo.get_by(Lenra.Datastore, user_id: app.user_id, application_id: app.id)

      assert datastore.data == %{"data" => "test new data"}
    end
  end
end
