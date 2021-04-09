defmodule LenraServers.EnvironmentServicesTest do
  @moduledoc """
    Test the environment services
  """
  use ExUnit.Case, async: false
  use Lenra.RepoCase

  alias LenraServices.{EnvironmentServices, LenraApplicationServices}
  alias Lenra.{Environment, Repo, LenraApplication}

  setup do
    {:ok, app: create_and_return_application()}
  end

  defp create_and_return_application do
    {:ok, %{inserted_user: user}} = UserTestHelper.register_john_doe()

    LenraApplicationServices.create(user.id, %{
      name: "mine-sweeper",
      service_name: "mine-sweeper",
      color: "FFFFFF",
      icon: "60189"
    })

    Enum.at(Repo.all(LenraApplication), 0)
  end

  describe "get" do
    test "not existing environment", %{app: _app} do
      assert nil == EnvironmentServices.get(0)
    end

    test "existing environment", %{app: _app} do
      {:ok, env} = Enum.fetch(Repo.all(Environment), 0)

      assert nil != EnvironmentServices.get(env.id)
    end
  end

  describe "get by" do
    test "name", %{app: _app} do
      assert nil != EnvironmentServices.get_by(name: "live")
    end

    test "ephemeral", %{app: _app} do
      assert nil != EnvironmentServices.get_by(is_ephemeral: false)
    end
  end

  describe "create" do
    test "environment successfully", %{app: app} do
      {:ok, user} = Enum.fetch(Repo.all(Lenra.User), 0)

      EnvironmentServices.create(app.id, user.id, %{
        name: "test_env",
        is_ephemeral: false
      })

      assert 2 == Enum.count(Repo.all(Environment))
    end

    test "environment but invalid params", %{app: app} do
      {:ok, user} = Enum.fetch(Repo.all(Lenra.User), 0)

      error =
        EnvironmentServices.create(app.id, user.id, %{
          name: 1234,
          is_ephemeral: "yes"
        })

      assert {:error, :inserted_env, _, _} = error
    end
  end

  describe "delete" do
    test "environment successfully", %{app: _app} do
      env = EnvironmentServices.get_by(name: "live")

      assert nil != env

      EnvironmentServices.delete(env)
      |> Repo.transaction()

      assert nil == EnvironmentServices.get_by(name: "live")
    end
  end
end
