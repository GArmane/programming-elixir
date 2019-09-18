defmodule ClientsRing do
  @root :root
  @timeout 2000

  # Creation and registration of ring nodes
  defp create_node, do: spawn(__MODULE__, :handle_request, [:nil])
  defp register_root(pid), do: :global.register_name(@root, pid)
  defp register_node(pid, root), do: send root, { :register, pid }

  # Handlers
  defp handle_tick(nil) do
    IO.puts "#{inspect self()}: TOCK"
    handle_request nil
  end
  defp handle_tick(next) do
    IO.puts "#{inspect self()}: TOCK"
    send next, { :tick }
    handle_request next
  end

  defp handle_timeout(nil), do: handle_request nil
  defp handle_timeout(next) do
    if :global.whereis_name(@root) == self() do
      IO.puts "#{inspect self()}: TICK"
      send next, { :tick }
    end
    handle_request next
  end

  defp handle_register(pid, nil), do: handle_request pid
  defp handle_register(pid, next) do
    send next, { :register, pid }
    handle_request next
  end

  def handle_request(next) do
    receive do
      { :tick } -> handle_tick(next)
      { :register, pid } -> handle_register(pid, next)
    after
      @timeout -> handle_timeout(next)
    end
  end

  def start do
    case :global.whereis_name(@root) do
      :undefined -> create_node() |> register_root
      root -> create_node() |> register_node(root)
    end
  end
end
