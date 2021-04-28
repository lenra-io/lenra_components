defmodule Bouncer.Policy do
  @moduledoc """
  This is the behavior for the app policy. All policy must implement the `authorize/3` function.
  The atom is the action
  The struct is the user
  The third param is any parameter useful to give or decline the permission
  """
  @callback authorize(atom(), struct(), any()) :: boolean() | :ok | :error | {:error, atom()}
end
