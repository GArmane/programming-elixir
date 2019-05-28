defmodule MyList do
  defp maximum([], greater) do
    greater
  end

  defp maximum([head | tail], greater) when head > greater do
    maximum tail, head
  end

  defp maximum([head | tail], greater) when greater > head do
    maximum tail, greater
  end

  def max([head | tail]) do
    maximum tail, head
  end
end
