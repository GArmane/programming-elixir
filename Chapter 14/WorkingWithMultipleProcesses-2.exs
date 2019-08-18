defmodule Tokens do
  def send_back() do
    receive do
      { sender, token } -> send sender, token
    end
  end

  defp prepare() do
    pid1 = spawn(Tokens, :send_back, [])
    pid2 = spawn(Tokens, :send_back, [])

    send pid1, { self(), "fred" }
    send pid2, { self(), "betty" }
  end

  defp listen() do
    receive do
      token ->
        IO.puts token
        listen
    end
  end

  def run() do
    prepare
    listen
  end
end

# Considering that in theory both calls do the exact same processing, the first message
# to be received is the first process which a message is sent.

# And this is what happens in practice as evidenciated by the execution of this script.
