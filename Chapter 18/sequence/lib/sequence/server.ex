defmodule Sequence.Server do
  require Logger
  use GenServer

  @vsn "1"

  defmodule State, do: defstruct current_number: 0, stash_pid: nil, delta: 1

  # GenServer implementation

  def format_status(_reason, [ _pdict, state ]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end

  def handle_call(:next_number, _from, state) do
    {
      :reply,
      state.current_number,
      %{ state | current_number: state.current_number + state.delta }
    }
  end

  def handle_cast({:increment_number, delta}, state) do
    {
      :noreply,
      %{ state | current_number: state.current_number + state.delta, delta: delta }
    }
  end

  def init(stash_pid) do
    current_number = Sequence.Stash.get_value(stash_pid)
    {:ok, {current_number, stash_pid}}
  end

  def terminate(_reason, state) do
    Sequence.Stash.save_value state
  end

  def code_change("1", old_state = { current_number, stash_pid }, _extra) do
    new_state = %State{
      current_number: current_number,
      stash_pid: stash_pid,
      delta: 1
    }
    Logger.info "Changing code from 1 to 2"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)
    {:ok, new_state}
  end


  # External API

  def start_link(stash_pid) do
    GenServer.start_link __MODULE__, stash_pid, name: __MODULE__
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end
end
