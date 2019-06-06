defmodule MyString do
  def is_ascii?([]), do: true
  def is_ascii?([ char | tail ]) when char in 0..127, do: is_ascii? tail
  def is_ascii?([ char | _tail ]), do: false
end

IO.inspect MyString.is_ascii?('a') # true
IO.inspect MyString.is_ascii?('abc') # true
IO.inspect MyString.is_ascii?('abç') # false
