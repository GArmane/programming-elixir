defmodule MyList do
  def flatten([]), do: []
  def flatten([head | tail]) when not is_list(head), do: [head] ++ flatten(tail)
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
end
