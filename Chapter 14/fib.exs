defmodule FibSolver do
  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)

  def fib(scheduler) do
    send scheduler, { :ready, self() }

    receive do
      {:fib, n, client } ->
        send client, { :answer, n, fib_calc(n), self() }
        fib(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end
end

defmodule Scheduler do
  defp schedule_processes(processes, queue, results) do
    receive do
      { :ready, pid } when queue != [] ->
        [ next | tail ] = queue
        send pid, { :fib, next, self() }
        schedule_processes(processes, tail, results)
      { :ready, pid} ->
        send pid, { :shutdown }
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn { n1, _ }, { n2, _ } -> n1 <= n2 end)
        end
      { :answer, number, result, _ } ->
        schedule_processes(processes, queue, [ { number, result } | results ])
    end
  end

  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map( fn _ -> spawn(module, func, [self()]) end )
    |> schedule_processes(to_calculate, [])
  end
end

to_process = [  40, 40, 40, 40, 40, 40 ]

Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run,
    [num_processes, FibSolver, :fib, to_process])

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n # time (s)"
  end

  :io.format "~2B ~.2f~n", [num_processes, time/1000000.0]
end

# [{40, 102334155}, {40, 102334155}, {40, 102334155},
#  {40, 102334155}, {40, 102334155}, {40, 102334155}]
#
# time (s)
# 1 20.31
# 2 10.45
# 3 9.90
# 4 10.07
# 5 9.66
# 6 9.22
# 7 9.18
# 8 9.17
# 9 9.18
# 10 9.24
