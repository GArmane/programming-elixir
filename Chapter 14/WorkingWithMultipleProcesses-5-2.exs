defmodule MultipleProcesses do
  import :timer, only: [ sleep: 1 ]

  def proc do
    receive do
      _ ->
        raise "ERROR"
        proc()
    end
  end

  def run do
    { pid, _ } = spawn_monitor(MultipleProcesses, :proc, [])

    send pid, { self(), "Message 1" }
    send pid, { self(), "Message 2" }
    send pid, { self(), "Message 3" }

    sleep 500
    listen()
  end

  def listen do
    receive do
      message ->
        IO.puts "#{inspect message}"
        listen()
      after 1000 ->
        IO.puts "Nothing happens"
    end
  end
end

MultipleProcesses.run()
# The process is created but is killed after a message
# is received. Any other messages are ignored.

# Parent receives a message after child dies informing event
