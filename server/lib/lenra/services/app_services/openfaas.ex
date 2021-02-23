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
    |> response(:get_apps)
  end

  def deploy_app(%Lenra.LenraApplication{} = app) do
    {base_url, headers} = get_http_context()

    Logger.debug("Deploy Openfaas application")

    url = "#{base_url}/system/functions"

    Finch.build(
      :post,
      url,
      headers,
      Jason.encode!(%{
        "image" => app.image,
        "service" => app.name,
        "envProcess" => app.env_process
      })
    )
    |> Finch.request(FaasHttp)
    |> response(:deploy_app)
  end

  def delete_app_openfaas(%Lenra.LenraApplication{} = app) do
    {base_url, headers} = get_http_context()

    Logger.debug("Remove Openfaas application")

    url = "#{base_url}/system/functions"

    Finch.build(
      :delete,
      url,
      headers,
      Jason.encode!(%{
        "functionName" => app.name
      })
    )
    |> Finch.request(FaasHttp)
    |> response(:delete_app)
  end

  defp response({:ok, %Finch.Response{status: 200, body: body}}, :get_apps) do
    {:ok, Jason.decode!(body)}
  end

  defp response({:ok, %Finch.Response{status: status_code}}, :deploy_app) when status_code in [200, 202] do
    {:ok, status_code}
  end

  defp response({:ok, %Finch.Response{status: status_code}}, :delete_app) when status_code in [200, 202, 404] do
    if status_code == 404 do
      Logger.error("The application was not found in Openfaas. It should not happen.")
    end

    {:ok, status_code}
  end

  defp response({:ok, %Finch.Response{}}, :delete_app) do
    raise "Openfaas could not delete the application. It should not happen."
  end

  defp response({:error, %Mint.TransportError{reason: _}}, _) do
    raise "Openfaas could not be reached. It should not happen."
  end

  defp response({:ok, %Finch.Response{status: status_code, body: body}}, _) when status_code not in [200, 202] do
    raise "Openfaas error (#{status_code}) #{body}"
  end
end
