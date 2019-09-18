defmodule OtpServers1.Stack do
  use GenServer

  def init(state) do
    { :ok, state }
  end

  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end
end
