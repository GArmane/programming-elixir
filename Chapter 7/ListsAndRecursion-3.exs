defmodule MyList do
  defp p_ceasar([], _n) do
    []
  end

  defp p_ceasar([head | tail], n) when head + n <= 122 do
    [ head + n | p_ceasar(tail, n) ]
  end

  defp p_ceasar([head | tail], n) when head + n > 122 do
    diff = (head + n) - 122
    [ 96 + diff | p_ceasar(tail, n) ]
  end

  defp sanitize(word) do
    word
      |> String.downcase
      |> String.to_charlist
  end

  def ceasar(list, n) do
    list
      |> sanitize
      |> p_ceasar(n)
  end
end
