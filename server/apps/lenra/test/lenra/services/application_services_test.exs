defmodule LenraServers.ApplicationServicesTest do
  use ExUnit.Case, async: false
  use Lenra.RepoCase

  alias LenraServices.LenraApplicationServices

  @moduledoc """
    Test the application services
  """

  @tag :register_user
  test "get app", %{user: user} do
    params = %{
      name: "mine-sweeper",
      service_name: "mine-sweeper",
      color: "FFFFFF",
      icon: "60189"
    }

    LenraApplicationServices.create(user.id, params)
    |> case do
      {:ok, %{inserted_application: app}} -> assert nil != LenraApplicationServices.get(app.id)
      {:error, _} -> assert false, "adding app failed"
    end
  end

  @tag :register_user
  test "get app by", %{user: user} do
    params = %{
      name: "mine-sweeper",
      service_name: "mine-sweeper",
      color: "FFFFFF",
      icon: "60189"
    }

    LenraApplicationServices.create(user.id, params)
    |> case do
      {:ok, %{inserted_application: app}} -> assert nil != LenraApplicationServices.get_by(name: app.name)
      {:error, _} -> assert false, "adding app failed"
    end
  end

  @tag :register_user
  test "delete app", %{user: user} do
    params = %{
      name: "mine-sweeper",
      service_name: "mine-sweeper",
      color: "FFFFFF",
      icon: "60189"
    }

    {:ok, %{inserted_application: app}} = LenraApplicationServices.create(user.id, params)

    assert nil != LenraApplicationServices.get_by(name: "mine-sweeper")

    LenraApplicationServices.delete(app)

    assert nil == LenraApplicationServices.get_by(name: "mine-sweeper")
  end
end
