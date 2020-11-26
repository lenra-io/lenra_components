defmodule TestWorker do
  def do_a_thing do
    "Doing a thing"
  end

  def do_a_thing(param) do
    "Doing another thing : #{param}"
  end
end

defmodule EventQueueTest do
  use ExUnit.Case

  alias LenraService.EventQueue
  alias LenraService.QueueGroup

  setup do
    assert :ok = EventQueue.add_worker(TestWorker, :do_a_thing)
  end

  test "GROUP add event with no params" do
    {:ok, pid} = QueueGroup.start_link()

    assert :ok = QueueGroup.add_event(pid, :event)
  end

  test "GROUP add event with params" do
    {:ok, pid} = QueueGroup.start_link()

    assert :ok = QueueGroup.add_event(pid, :event, [])
    assert :ok = QueueGroup.add_event(pid, :event, [:test])
    assert :ok = QueueGroup.add_event(pid, :event, [:test, "test"])
  end

  test "GROUP add worker" do
    {:ok, pid} = QueueGroup.start_link()

    assert :ok = QueueGroup.add_worker(pid, TestWorker)
    assert :ok = QueueGroup.add_worker(pid, TestWorker)

    # Check that the number of workers is 2
    assert 2 = Enum.count(:sys.get_state(pid))
  end

  test "GROUP add worker and event" do
    {:ok, pid} = QueueGroup.start_link()

    assert :ok = QueueGroup.add_worker(pid, TestWorker)

    assert :ok = QueueGroup.add_event(pid, :do_a_thing)
  end

  test "QUEUE add workers" do
    # Worker added in setup
    assert 1 = Enum.count(:sys.get_state(EventQueue))
  end

  test "QUEUE ignore add events" do
    EventQueue.add_event(:do_a_thing, [])
    # Check that the state was not updated (event ignored)
    assert %{} = :sys.get_state(EventQueue)
    EventQueue.add_event(:do_a_thing, [:test])
    assert %{} = :sys.get_state(EventQueue)
  end

  test "QUEUE add workers and events" do
    EventQueue.add_worker(TestWorker, :do_a_thing)
    EventQueue.add_worker(TestWorker, :do_a_thing)

    assert 1 = Enum.count(:sys.get_state(EventQueue))

    EventQueue.add_event(:do_a_thing, [:test])
  end
end
