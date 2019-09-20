defmodule Stack.Server do
  use GenServer

  # GenServer interface

  def handle_call(:pop, _from, { [head | tail], stash_pid}) do
    { :reply, head, {tail, stash_pid}}
  end

  def handle_cast({:push, item}, { stack, stash_pid }) do
    { :noreply, {[item | stack], stash_pid}}
  end

  def init(stash_pid) do
    current_stash = Stack
      .Stash
      .get_value(stash_pid)

    {:ok, {current_stash, stash_pid}}
  end

  def terminate(reason, state) do
    {current_stash, stash_pid} = state
    Stack
      .Stash
      .save_value(stash_pid, current_stash)

    IO.puts "Terminating..."
    IO.puts "Reason: #{inspect reason}"
    IO.puts "State: #{inspect state}"
  end

  # External API

  def start_link(state) do
    GenServer.start_link __MODULE__, state, name: __MODULE__
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(item) do
    GenServer.cast __MODULE__, {:push, item}
  end
end
