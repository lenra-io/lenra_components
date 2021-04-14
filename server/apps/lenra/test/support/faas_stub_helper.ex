defmodule Lenra.FaasStub do
  @moduledoc """
    Helper to generate stubbed apps for testing
  """
  use ExUnit.CaseTemplate

  def create_faas_stub do
    Bypass.open(port: 1234)
  end

  def stub_app(bypass, app_name) do
    url = "/function/#{app_name}"

    Bypass.stub(bypass, "POST", url, &handle_action(&1, app_name))

    {bypass, app_name}
  end

  def expect_app_list_once(bypass, result) do
    expect_once("GET", bypass, result)
  end

  def expect_deploy_app_once(bypass, result) do
    expect_once("POST", bypass, result)
  end

  def expect_delete_app_once(bypass, result) do
    expect_once("DELETE", bypass, result)
  end

  defp expect_once(http_method, bypass, result) do
    url = "/system/functions"

    Bypass.expect_once(bypass, http_method, url, fn conn ->
      case result do
        {:error, code, message} ->
          Plug.Conn.resp(conn, code, message)

        any ->
          Plug.Conn.resp(conn, 200, Jason.encode!(any))
      end
    end)

    bypass
  end

  @spec stub_action_once(tuple(), String.t(), map() | {:error, number(), String.t()}) :: tuple()
  def stub_action_once({_bypass, app_name} = app, action_code, result) do
    push(app_name, {action_code, result})
    app
  end

  defp handle_action(conn, app_name) do
    {:ok, body, _} = Plug.Conn.read_body(conn)
    %{"action" => action_code} = Jason.decode!(body)

    {stored_action_code, result} = pop(app_name)
    assert stored_action_code == action_code

    case result do
      {:error, code, message} ->
        Plug.Conn.resp(conn, code, message)

      data ->
        Plug.Conn.resp(conn, 200, Jason.encode!(data))
    end
  end

  def init do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def pop(app_name) do
    case Agent.get(__MODULE__, &Map.get(&1, app_name, [])) do
      [head | tail] ->
        Agent.update(__MODULE__, &Map.put(&1, app_name, tail))
        head

      [] ->
        raise "App Stub Helper : No stub for app #{app_name}. You probably forgot a call case."
    end
  end

  def push(app_name, call_result) do
    Agent.update(__MODULE__, &Map.put(&1, app_name, Map.get(&1, app_name, []) ++ [call_result]))
  end
end
