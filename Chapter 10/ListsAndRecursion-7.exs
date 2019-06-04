defmodule MyList do
  # Span implementation
  def span(to, to), do: [to]
  def span(from, to) when from > to, do: [from] ++ span(from - 1, to)
  def span(from, to), do: [from] ++ span(from + 1, to)

  # Primes from 2 to n
  def primes(n) do
    [2 | (for x <- span(2, n), Enum.all?(span(2, x-1), &(rem(x, &1) != 0)), do: x)]
  end
end
