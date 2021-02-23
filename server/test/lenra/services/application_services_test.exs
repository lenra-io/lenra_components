defmodule LenraServers.ApplicationServicesTest do
  use ExUnit.Case, async: false
  use Lenra.RepoCase

  alias LenraWeb.AppStub, as: AppStub

  @moduledoc """
    Test the Errors for applications
  """

  test "register app" do
    AppStub.create_faas_stub()
    |> AppStub.expect_deploy_app_once(%{"ok" => "200"})

    %Lenra.LenraApplication{}
    |> Lenra.LenraApplication.changeset(%{
      image: "test",
      name: "mine-sweeper",
      env_process: "node index.js",
      color: "FFFFFF",
      icon: "60189"
    })
    |> LenraServices.ApplicationServices.register_app()
    |> Lenra.Repo.transaction()
  end

  test "delete app" do
    AppStub.create_faas_stub()
    |> AppStub.expect_deploy_app_once(%{"ok" => "200"})
    |> AppStub.expect_delete_app_once(%{"ok" => "200"})

    %Lenra.LenraApplication{}
    |> Lenra.LenraApplication.changeset(%{
      image: "test",
      name: "mine-sweeper",
      env_process: "node index.js",
      color: "FFFFFF",
      icon: "60189"
    })
    |> LenraServices.ApplicationServices.register_app()
    |> Lenra.Repo.transaction()

    app = Enum.at(Lenra.Repo.all(Lenra.LenraApplication), 0)

    LenraServices.ApplicationServices.delete_app(app)
    |> Lenra.Repo.transaction()
  end
end
