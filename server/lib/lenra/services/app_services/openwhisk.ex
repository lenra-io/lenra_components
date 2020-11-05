defmodule LenraServices.Openwhisk do
  @moduledoc """
    The service that manage calls to an openwhisk action with `run_action/3`
  """
  require Logger

  defp get_http_context do
    host = Application.fetch_env!(:lenra, :ow_host)
    port = Application.fetch_env!(:lenra, :ow_port)
    auth = Application.fetch_env!(:lenra, :ow_auth)

    base_url = "#{host}:#{port}/api/v1/namespaces/guest"
    header = [{"Authorization", auth}]
    {base_url, header}
  end

  @doc """
    Run a HTTP POST request with needed headers and body to call an Openwhisk Action and decode the response body.

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

    url = "#{base_url}/actions/#{app_name}/main?result=true&blocking=true"

    Logger.debug("Call OW Action : #{app_name}")

    headers = [{"Content-Type", "application/json"} | headers]
    params = Map.put(params, :action, action_code)
    body = LenraServices.Jiffy.encode!(params)

    Logger.info("Run app #{app_name} with action #{action_code}")

    Finch.build(:post, url, headers, body)
    |> Finch.request(Openwhisk)
    |> response()
  end

  def run_app_list do
    {base_url, headers} = get_http_context()

    Logger.debug("Get OW app list")

    url = "#{base_url}/packages"

    Finch.build(:get, url, headers)
    |> Finch.request(Openwhisk)
    |> response()
  end

  defp response({:ok, %Finch.Response{status: 200, body: body}}) do
    {:ok, LenraServices.Jiffy.decode!(body)}
  end

  defp response({:ok, %Finch.Response{status: status_code, body: body}}) do
    {:error, "Error (#{status_code}) #{body}"}
  end

  defp response({:error, %{reason: reason}}) do
    {:error, "Action internal error : #{reason}"}
  end
end
