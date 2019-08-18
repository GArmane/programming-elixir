defmodule ParallelMap do
  def pmap(collection, fun) do
    me = self()

    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (send me, { self(), fun.(elem) }) end
    end)
    |> Enum.map(fn (pid) ->
      receive do
        { ^pid, result } -> result
      end
    end)
  end
end

ParallelMap.pmap(1..10, &IO.puts/1)
