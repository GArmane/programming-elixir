defmodule CatCounter do
  def process(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :process, params, client } ->
        send client, { :answer, params, count_cats_in_dir(params[:dir]), self() }
        process(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  def count_cats_in_dir(path) do
    File.ls!(path)
    |> Enum.map(fn filename ->
      count_cats_in_file("#{path}/#{filename}")
    end)
    |> Enum.sum
  end

  def count_cats_in_file(path) do
    File.stream!(path)
    |> Enum.map(fn line ->  count_cats_in_line(line) end)
    |> Enum.sum
  end

  def count_cats_in_line(str) do
    str
    |> String.split
    |> Enum.filter(fn word -> String.contains?(word, "cat") end)
    |> Enum.count
  end
end

defmodule Scheduler do
  defp schedule_processes(processes, queue, results \\ []) do
    receive do
      { :ready, pid } when queue != [] ->
        [ next | tail ] = queue
        send pid, { :process, next, self()  }
        schedule_processes(processes, tail, results)

      { :ready, pid } ->
        send pid, { :shutdown }
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          results
        end

      { :answer, params, result, _pid } ->
        schedule_processes(processes, queue, [{ params, result } | results])
    end
  end

  def run(num_processes, module, fun, data) do
    (1..num_processes)
    |> Enum.map(fn _ -> spawn(module, fun, [self()]) end)
    |> schedule_processes(data)
  end
end

to_process = 1..1000 |> Enum.map(fn _ ->
  %{ dir: "cats" }
end)

Enum.each 1..10, fn num_processes ->
  { time, result } = :timer.tc(Scheduler, :run,
    [num_processes, CatCounter, :process, to_process])

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n # time (s)"
  end
  :io.format "~2B ~.2f~n", [num_processes, time/1000000.0]
end

# [{%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500}, {%{dir: "cats"}, 500},
#  {%{...}, ...}, {...}, ...]

#  # time (s)
#  1 139.60
#  2 96.98
#  3 76.65
#  4 69.33
#  5 67.41
#  6 68.39
#  7 65.89
#  8 65.93
#  9 67.56
# 10 69.30
