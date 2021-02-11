defmodule LenraServers.QueueGroup do
  @moduledoc """
    Groupe de queue permettant à plusieurs worker de réagir à un seul évent de différente façon.
    Utilisé par EventQueue, ne doit pas être utilisé seul.
  """
  use GenServer

  def init(:ok) do
    {:ok, []}
  end

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def handle_cast({:add_event, event, args}, queues_list) do
    Enum.each(queues_list, fn queue ->
      Honeydew.async({event, args}, queue)
    end)

    {:noreply, queues_list}
  end

  def handle_call({:add_worker, worker}, _from, queues_list) do
    queue_name = inspect(make_ref())

    Honeydew.start_queue(queue_name, queue: Honeydew.Queue.ErlangQueue)
    Honeydew.start_workers(queue_name, worker)

    {:reply, :ok, [queue_name | queues_list]}
  end

  @spec add_event(pid, atom, list(any)) :: any
  def add_event(pid, event, args \\ []) do
    GenServer.cast(pid, {:add_event, event, args})
  end

  def add_worker(pid, worker) do
    GenServer.call(pid, {:add_worker, worker})
  end
end
