defmodule MultipleProcesses do
  import :timer, only: [ sleep: 1 ]

  def proc do
    receive do
      { sender, msg } ->
        send sender, msg
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
# Waiting doesn't influence output
