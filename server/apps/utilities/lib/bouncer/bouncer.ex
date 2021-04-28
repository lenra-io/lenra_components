defmodule Bouncer do
  @moduledoc """
    Base module that contains all the utilities for the authorization process.
  """

  @doc """
  This function ask the given authorization module to give the permission (or not) to the given user for the given action and params
  return true if the module give the authorization, false otherwise
  """
  @spec allow?(atom(), atom(), any(), any()) :: boolean()
  def allow?(module, action, user \\ nil, params \\ nil) do
    apply(module, :authorize, [action, user, params])
    |> format_to_boolean
  end

  @spec format_to_boolean(any()) :: boolean()
  defp format_to_boolean(:ok), do: true
  defp format_to_boolean(true), do: true
  defp format_to_boolean(_), do: false

  @doc """
  This function ask the given authorization module to give the permission (or not) to the given user for the given action and params
  return :ok if the module give the authorization.
  Otherwise {:error, reason} is returned. By default reason is `:forbidden`
  if the `authorize` function of the module return an other reason then this reason is return instead.
  """
  @spec allow(atom(), atom(), any(), any()) :: :ok | {:error, atom()}
  def allow(module, action, user \\ nil, params \\ nil) do
    apply(module, :authorize, [action, user, params])
    |> format_to_error()
  end

  @default_error {:error, :forbidden}

  @spec format_to_error(any()) :: :ok | {:error, atom()}
  defp format_to_error(true), do: :ok
  defp format_to_error(:ok), do: :ok
  defp format_to_error(false), do: @default_error
  defp format_to_error(:error), do: @default_error
  defp format_to_error({:error, reason}), do: {:error, reason}
  defp format_to_error(_), do: @default_error
end
