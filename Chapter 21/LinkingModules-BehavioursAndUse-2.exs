defmodule Tracer do
  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end

  def dump_args(args),
  do: args |> Enum.map(&inspect/1) |> Enum.join(", ")

  def dump_defn(name, args),
  do: "#{name}, #{dump_args(args)}"

  defmacro def(definition={name, _, args}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts IO.ANSI.format([
          :blue, "==> call: ",
          :red, :bright, "#{Tracer.dump_defn(unquote(name), unquote(args))}"
        ])
        result = unquote(content)
        IO.puts IO.ANSI.format([
          :blue, "<== result: ",
          :green, :bright, "#{result}"
        ])
        result
      end
    end
  end
end

defmodule Test do
  use Tracer

  def puts_sum_three(a, b, c), do: IO.inspect a + b + c
  def add_list(list), do: Enum.reduce(list, 0, &(&1+&2))
end

Test.puts_sum_three(1, 2, 3)
Test.add_list([5, 6, 7, 8])
