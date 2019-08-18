defmodule MultipleProcesses do
  import :timer, only: [ sleep: 1 ]

  def proc do
    receive do
      message ->
        raise "ERROR"
        proc()
    end
  end

  def run do
    pid = spawn(MultipleProcesses, :proc, [])

    send pid, { self(), "Message 1" }
    send pid, { self(), "Message 2" }
    send pid, { self(), "Message 3" }

    sleep 500
    listen()
  end

  def listen do
    receive do
      message ->
        IO.puts message
        listen()
      after 1000 ->
        IO.puts "Nothing happens"
    end
  end
end

MultipleProcesses.run()
# The process is created but is killed after a message
# is received. Any other messages are ignored.

# Parent dies with "Nothing happens"
