defmodule LenraServers.OpenfaasMeasurementServicesTest do
  use ExUnit.Case
  use Lenra.RepoCase

  alias LenraServices.OpenfaasRunActionMeasurementServices
  alias Lenra.OpenfaasRunActionMeasurement

  @moduledoc """
    Test the openfaas measurement services
  """

  setup do
    {:ok, user: create_user()}
  end

  defp create_user do
    {:ok, %{inserted_user: user}} = UserTestHelper.register_john_doe()

    user
  end

  describe "get" do
    test "measurement successfully", %{user: user} do
      OpenfaasRunActionMeasurementServices.create(user.id, %{application_name: "test", duration: 1})

      tmp_measurement = Enum.at(Repo.all(OpenfaasRunActionMeasurement), 0)

      measurement = OpenfaasRunActionMeasurementServices.get(tmp_measurement.id)

      assert measurement == tmp_measurement

      assert %OpenfaasRunActionMeasurement{application_name: "test", duration: 1} = measurement

      assert measurement.user_id == user.id
    end

    test "measurement which does not exist", %{user: _user} do
      assert nil == OpenfaasRunActionMeasurementServices.get(0)
    end
  end

  describe "get_by" do
    test "measurement succesfully", %{user: user} do
      OpenfaasRunActionMeasurementServices.create(user.id, %{application_name: "test", duration: 1})

      tmp_measurement = Enum.at(Repo.all(OpenfaasRunActionMeasurement), 0)
      measurement = OpenfaasRunActionMeasurementServices.get_by(application_name: "test", duration: 1)

      assert tmp_measurement == measurement

      assert %OpenfaasRunActionMeasurement{application_name: "test", duration: 1} = measurement

      assert measurement.user_id == user.id
    end

    test "measurement which does not exist", %{user: _user} do
      assert nil == OpenfaasRunActionMeasurementServices.get_by(application_name: "test", duration: 1)
    end
  end

  describe "create" do
    test "measurement successfully", %{user: user} do
      OpenfaasRunActionMeasurementServices.create(user.id, %{application_name: "test", duration: 1})

      measurement = Enum.at(Repo.all(OpenfaasRunActionMeasurement), 0)

      assert %OpenfaasRunActionMeasurement{application_name: "test", duration: 1} = measurement

      assert measurement.user_id == user.id
    end

    test "measurement but user does not exist" do
      error = OpenfaasRunActionMeasurementServices.create(-1, %{application_name: "test", duration: 1})
      assert {:error, _changeset} = error
    end
  end
end
