defmodule Stack do
  use GenServer

  # GenServer interface

  def init(state) do
    { :ok, state }
  end

  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end

  def handle_cast({:push, item }, state) do
    { :noreply, [item | state] }
  end

  # External API

  def start_link(state) do
    GenServer.start_link __MODULE__, state, name: __MODULE__
  end
end
