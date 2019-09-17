defmodule Ticker do
  @interval 2000 # 2 seconds
  @name :ticker

  defp handle_register(pid, clients) do
    IO.puts "registering #{inspect pid}"
    generator([ pid | clients ])
  end

  defp handle_timeout([]), do: generator([])

  defp handle_timeout([head | tail]) do
    send head, { :tick }
    generator(tail ++ [head])
  end

  def generator(clients \\ []) do
    receive do
      { :register, pid } -> handle_register(pid, clients)
    after
      @interval ->
        IO.puts "tick"
        handle_timeout(clients)
    end
  end

  def start do
    pid = spawn(__MODULE__, :generator, [])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end
end

defmodule Client do
  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client"
        receiver()
    end
  end

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end
end
