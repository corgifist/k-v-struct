defmodule KVStruct do
  use GenServer

  def loop(server) do
    GenServer.cast(server, :recieve_loop)
  end

  def start do
    GenServer.start(__MODULE__, %{})
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  @impl true
  def handle_cast(:recieve_loop, state) do
    receive do
      msg -> IO.inspect(msg, label: "RECIEVE LOOP")
    end
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.fetch!(state, key), state}
  end
end
