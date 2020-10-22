defmodule LenraServers.Queue do
  @moduledoc """
    GenServer to handle a queue for uniq client
  """
  use GenServer
  require Logger

  @name __MODULE__

  # GenServer Callbacks

  @impl true
  def init(_) do
    {:ok, :none}
  end

  @impl true
  def handle_cast({:run, message_name, module, fun, args, from_pid}, _) do
    res = apply(module, fun, args)
    send(from_pid, {message_name, res})
    {:noreply, :none}
  end

  # Client API
  def start_link, do: GenServer.start_link(@name, :none)

  def run(pid, message_name, module, fun, args, from_pid) do
    GenServer.cast(pid, {:run, message_name, module, fun, args, from_pid})
  end
end
