defmodule Times do
  def double(n) do
    n * 2
  end

  def triple(n) do
    n * 3
  end

  def quaduple(n) do
    double(double(2))
  end
end
