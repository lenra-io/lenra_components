defmodule AppChannelMonitor do
  @moduledoc """
    The app_channel monitor which monitors the time spent by the client on an app
  """

  use GenServer

  alias Lenra.Telemetry

  def monitor(pid, metadata) do
    GenServer.call(__MODULE__, {:monitor, pid, metadata})
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:monitor, pid, metadata}, _from, state) do
    Process.monitor(pid)

    start_time = Telemetry.start(:client_app_channel)

    {:reply, :ok, Map.put(state, pid, {start_time, metadata})}
  end

  def handle_info({:DOWN, _ref, :process, pid, _reason}, state) do
    {{start_time, metadata}, new_state} = Map.pop(state, pid)

    Telemetry.stop(:client_app_channel, start_time, metadata)

    {:noreply, new_state}
  end
end
