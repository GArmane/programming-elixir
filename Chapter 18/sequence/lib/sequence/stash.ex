defmodule Sequence.Stash do
  require Logger
  use GenServer

  @vsn "0"

  defmodule State, do: defstruct current_number: 0, stash_pid: nil, delta: 1

  # GenServer implementation

  def handle_call(:get_value, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:save_value, state}, _current_state) do
    {:noreply, state}
  end

  def init(state) do
    {:ok, state}
  end

  def code_change("0", old_state = { current_number, stash_pid }, _extra) do
    new_state = %State{
      current_number: current_number,
      stash_pid: stash_pid,
      delta: 1,
    }
    Logger.info "Changing code from 0 to 1"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)
    {:ok, new_state}
  end

  # External API

  def start_link(state) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, state)
  end

  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  def save_value(pid, state) do
    GenServer.cast pid, {:save_value, state}
  end
end
