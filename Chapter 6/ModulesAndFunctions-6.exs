defmodule Chop do
  def guess(actual, range = min..max) do
    maybe = div(min + max, 2)
    IO.puts "Is it #{maybe}"
    guess(actual, maybe, range)
  end

  def guess(actual, actual, _) do
    IO.puts "Correct, it is #{actual}"
  end

  def guess(actual, maybe, _..max) when maybe < actual do
    guess(actual, maybe+1..max)
  end

  def guess(actual, maybe, min.._) when maybe > actual do
    guess(actual, min..maybe-1)
  end
end
