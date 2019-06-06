defmodule MyString do
  defp sanitize(word) do
    word
    |> String.downcase
    |> String.to_charlist
    |> Enum.sort
  end

  defp sanitize(word1, word2) do
    {sanitize(word1), sanitize(word2)}
  end

  def anagram?(word1, word2) do
    {first, second} = sanitize(word1, word2)
    first == second
  end
end

IO.inspect MyString.anagram?("roma", "maro") # true
IO.inspect MyString.anagram?("god", "dog") # true
IO.inspect MyString.anagram?("banana", "test") # false
IO.inspect MyString.anagram?("seti", "test") # false
