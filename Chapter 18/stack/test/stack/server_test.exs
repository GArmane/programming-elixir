defmodule Stack.Server.Test do
  use ExUnit.Case
  doctest Stack.Server

  test "#pop" do
    input = 5
    Stack.Server.push input

    value = Stack.Server.pop
    assert value == input
  end

  test "#push" do
    input = 5
    :ok = Stack.Server.push input
  end
end
