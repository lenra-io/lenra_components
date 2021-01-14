defmodule LenraServices.Openfaas do
  @moduledoc """
    The service that manage calls to an Openfaas action with `run_action/3`
  """
  require Logger

  defp get_http_context do
    base_url = Application.fetch_env!(:lenra, :faas_url)
    auth = Application.fetch_env!(:lenra, :faas_auth)

    headers = [{"Authorization", auth}]
    {base_url, headers}
  end

  @doc """
    Run a HTTP POST request with needed headers and body to call an Openfaas Action and decode the response body.

    Returns `{:ok, decoded_body}` if the HTTP Post succeed
    Returns `{:error, reason}` if the HTTP Post fail
  """
  @spec run_action(String.t(), String.t(), map) :: {:error, String.t()} | {:ok, map}
  def run_action(
        app_name,
        action_code,
        params
      )
      when is_binary(app_name) and is_binary(action_code) and is_map(params) do
    {base_url, headers} = get_http_context()

    url = "#{base_url}/function/#{app_name}"

    Logger.debug("Call to Openfaas : #{app_name}")

    headers = [{"Content-Type", "application/json"} | headers]
    params = Map.put(params, :action, action_code)
    body = Jason.encode!(params)

    Logger.info("Run app #{app_name} with action #{action_code}")

    Finch.build(:post, url, headers, body)
    |> Finch.request(FaasHttp)
    |> response()
  end

  def fetch_app_list do
    {base_url, headers} = get_http_context()

    Logger.debug("Get Openfaas app list")

    url = "#{base_url}/system/functions"

    Finch.build(:get, url, headers)
    |> Finch.request(FaasHttp)
    |> response()
  end

  defp response({:ok, %Finch.Response{status: 200, body: body}}) do
    {:ok, Jason.decode!(body)}
  end

  defp response({:ok, %Finch.Response{status: status_code, body: body}}) do
    {:error, "Error (#{status_code}) #{body}"}
  end

  defp response({:error, %{reason: reason}}) do
    {:error, "Error : #{reason}"}
  end
end
