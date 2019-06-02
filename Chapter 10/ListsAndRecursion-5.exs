defmodule MyEnum do
  # All implementation
  def all?([], _predicate), do: true
  def all?([head | tail], predicate), do: predicate.(head) and all?(tail, predicate)

  def each([], _func), do: :ok
  def each([head | tail], func) do
    func.(head)
    each tail, func
  end

  # Filter implementation
  def filter([], _predicate), do: []
  def filter([head | tail], predicate) do
    if predicate.(head) do
      [head] ++ filter(tail, predicate)
    else
      filter(tail, predicate)
    end
  end

  # Split implementation
  defp _split([head | tail], count, result) when length(result) < count do
    _split tail, count, result ++ [head]
  end
  defp _split(enumerable, _count, result), do: { result, enumerable }

  def split(enumerable, count) when count >= 0, do: _split enumerable, count, []
  def split(enumerable, count), do: _split enumerable, count + length(enumerable), []

  # Reverse implementation for Take
  def reverse([]), do: []
  def reverse([head | tail]), do: reverse(tail) ++ [head]

  # Take implementation
  defp _take([head | tail], count, acc) when length(acc) < count, do: _take(tail, count, acc ++ [head])
  defp _take(_list, _count, acc), do: acc

  def take(list, count) when count >= 0, do: _take(list, count, [])
  def take(list, count) when count < 0 do
    positive_count = abs(count)
    list
    |> reverse
    |> _take(positive_count, [])
    |> reverse
  end
end
