defmodule LenraServers.AppQueueHandler do
  @moduledoc """
    GenServer that handle all the queue for each client
  """
  use GenServer
  require Logger

  @name __MODULE__

  # GenServer Callbacks

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:push, key, message_name, module, fun, args, from_pid}, servers) do
    pid = get_server(servers, key)
    LenraServers.Queue.run(pid, message_name, module, fun, args, from_pid)
    {:noreply, Map.put(servers, key, pid)}
  end

  defp get_server(servers, key) do
    if Map.has_key?(servers, key) do
      Map.get(servers, key)
    else
      {:ok, pid} = LenraServers.Queue.start_link()
      pid
    end
  end

  def start_link(_), do: GenServer.start_link(@name, [], name: @name)

  def push(key, message_name, module, fun, args, from_pid) do
    GenServer.cast(@name, {:push, key, message_name, module, fun, args, from_pid})
  end
end
