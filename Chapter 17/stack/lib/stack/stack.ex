defmodule Stack.Server do
  use GenServer

  # GenServer interface

  def init(state) do
    { :ok, state }
  end

  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end

  def handle_cast({:push, item}, state) do
    { :noreply, [item | state] }
  end

  def terminate(reason, state) do
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
