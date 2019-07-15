defmodule FizzBuzz do
  defp test_value(n) do
    case n do
      n when rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
      n when rem(n, 3) == 0 -> "Fizz"
      n when rem(n, 5) == 0 -> "Buzz"
      _ -> n
    end
  end

  def upto(n) when n > 0 do
    1..n |> Enum.map(&test_value/1)
  end
end
