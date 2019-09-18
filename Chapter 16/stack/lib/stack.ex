defmodule Stack do
  use GenServer

  def init(state) do
    { :ok, state }
  end

  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end

  def handle_cast({:push, item }, state) do
    { :noreply, [item | state] }
  end
end
