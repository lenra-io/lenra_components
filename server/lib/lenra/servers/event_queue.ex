defmodule LenraServers.EventQueue do
  @moduledoc """
    Module principal de l'EventQueue.
    Permet d'ajouter des worker avec `LenraServices.EventQueue.add_worker/2`.
    Permet d'envoyer des évennements avec `LenraServices.EventQueue.add_event/2`
  """
  use GenServer

  alias LenraServers.QueueGroup

  def init(:ok) do
    {:ok, %{}}
  end

  def start_link(workers) do
    # Start link with name registered in :global
    res = GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
    workers.()
    res
  end

  def handle_cast({:add_event, event, args}, state) do
    # Get "pid" if event exists, else "nil"
    pid = Map.get(state, event)

    if pid != nil do
      # Add event to queue group
      QueueGroup.add_event(pid, event, args)
    end

    {:noreply, state}

    # Ignore call if event does not exist
  end

  def handle_call({:add_worker, worker, event}, _from, state) do
    # Get "pid" if event exists, else "nil"
    Map.get(state, event)
    |> add_worker_to_group_queue(state, event, worker)
  end

  defp add_worker_to_group_queue(nil, state, event, worker) do
    {:ok, pid} = QueueGroup.start_link()
    state = Map.put(state, event, pid)
    add_worker_to_group_queue(pid, state, event, worker)
  end

  defp add_worker_to_group_queue(pid, state, _event, worker) do
    QueueGroup.add_worker(pid, worker)
    {:reply, :ok, state}
  end

  @doc """
  Permet d'envoyer un event au système.
  event est un atom
  args est un tableau d'argument passé en paramètre du worker.
  """
  def add_event(event, args \\ []) do
    # Call global MainModule's add_event
    GenServer.cast(__MODULE__, {:add_event, event, args})
    {:ok, nil}
  end

  @doc """
  Permet d'ajouter un worker de traitement d'event au système.
  worker est le module du worker
  event est un atom correspondant au nom de la fonction.
  """
  def add_worker(worker, event) do
    # Call global MainModule's add_worker
    GenServer.call(__MODULE__, {:add_worker, worker, event})
  end
end
