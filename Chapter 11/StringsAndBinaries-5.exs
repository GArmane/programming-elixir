defmodule MyString do
  defp centralize(word, line_width) do
    String.rjust(word, div(String.length(word) + line_width, 2), ?\s)
  end

  defp find_longest_word_length(words) do
    words
    |> Enum.max_by(&String.length/1)
    |> String.length
  end

  defp print(word, padding) do
    IO.puts centralize(word, padding)
  end

  def center(words) do
    len = find_longest_word_length(words)
    words |> Enum.each(&(print &1, len))
  end
end
