defmodule MyString do
  defp _calculate([ ?+ | tail ], num), do: num + _calculate(tail, 0)
  defp _calculate([ ?- | tail ], num), do: num - _calculate(tail, 0)
  defp _calculate([ ?/ | tail ], num), do: num / _calculate(tail, 0)
  defp _calculate([ ?* | tail ], num), do: num * _calculate(tail, 0)
  defp _calculate([ ?\s | tail ], num), do: _calculate(tail, num)
  defp _calculate([], num2), do: num2

  defp _calculate([ digit | tail ], num) when digit in '0123456789' do
    _calculate tail, num * 10 + (digit - ?0)
  end

  def calculate(expr), do: _calculate(expr, 0)
end

IO.inspect MyString.calculate('1 + 2') # 3
IO.inspect MyString.calculate('23 - 3') # 20
IO.inspect MyString.calculate('2 * 5') # 10
IO.inspect MyString.calculate('30 / 5') # 6
IO.inspect MyString.calculate('2350 + 873') # 3223
IO.inspect MyString.calculate('564 - 742') # -178
IO.inspect MyString.calculate('735 * 22') # 16170
IO.inspect MyString.calculate('8974 / 873') # 10.279495990836198

