defmodule Stack.Stash do
  use GenServer

  # GenServer implementation

  def handle_call(:get_value, _from, current_value) do
    {:reply, current_value, current_value}
  end

  def handle_cast({:save_value, value}, _current_value) do
    {:noreply, value}
  end

  def init(state) do
    {:ok, state}
  end

  # External API

  def start_link(state) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, state)
  end

  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  def save_value(pid, value) do
    GenServer.cast pid, {:save_value, value}
  end
end
