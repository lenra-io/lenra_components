defmodule LenraServers.ApplicationServicesTest do
  use ExUnit.Case, async: false
  use Lenra.RepoCase

  alias LenraWeb.AppStub
  alias LenraServices.LenraApplicationServices

  @moduledoc """
    Test the application services
  """

  @tag :register_user
  test "register app", %{user: user} do
    AppStub.create_faas_stub()
    |> AppStub.expect_deploy_app_once(%{"ok" => "200"})

    params = %{
      image: "test",
      name: "mine-sweeper",
      env_process: "node index.js",
      color: "FFFFFF",
      icon: "60189"
    }

    LenraApplicationServices.create_and_deploy(user.id, params)
    |> case do
      {:ok, _} -> assert true
      {:error, _} -> assert false, "adding app failed"
    end

    assert nil != LenraApplicationServices.get_by(name: "mine-sweeper")
  end

  @tag :register_user
  test "delete app", %{user: user} do
    AppStub.create_faas_stub()
    |> AppStub.expect_deploy_app_once(%{"ok" => "200"})
    |> AppStub.expect_delete_app_once(%{"ok" => "200"})

    params = %{
      image: "test",
      name: "mine-sweeper",
      env_process: "node index.js",
      color: "FFFFFF",
      icon: "60189"
    }

    {:ok, %{inserted_application: app}} = LenraApplicationServices.create_and_deploy(user.id, params)

    assert nil != LenraApplicationServices.get_by(name: "mine-sweeper")

    LenraApplicationServices.delete_and_undeploy(app)

    assert nil == LenraApplicationServices.get_by(name: "mine-sweeper")
  end
end
