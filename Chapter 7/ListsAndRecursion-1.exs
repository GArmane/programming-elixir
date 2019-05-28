defmodule MyList do
  def mapsum([], func) do
    func.(0)
  end

  def mapsum([head | tail], func) do
    func.(head) + mapsum(tail, func)
  end
end
