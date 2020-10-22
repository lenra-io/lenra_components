defmodule LenraServers.OpenwhiskTest do
  use ExUnit.Case, async: true

  alias LenraWeb.AppStub, as: AppStub

  @moduledoc """
    Test the Errors for some routes
  """

  setup do
    app = AppStub.create_owstub() |> AppStub.stub_app("StubApp")
    {:ok, app: app}
  end

  test "Openwhisk correctly handle ok 200 and decode data", %{app: app} do
    AppStub.stub_action_once(app, "InitData", %{"data" => "any data"})

    assert {:ok, %{"data" => "any data"}} ==
             LenraServices.Openwhisk.run_action("StubApp", "InitData", %{"toto" => "tata"})
  end

  test "Openwhisk correctly handle 404 not found", %{app: app} do
    AppStub.stub_action_once(app, "InitData", {:error, 404, "Not Found"})

    assert {:error, "Error (404) Not Found"} ==
             LenraServices.Openwhisk.run_action("StubApp", "InitData", %{"toto" => "tata"})
  end
end
