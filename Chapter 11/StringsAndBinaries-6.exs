defmodule MyString do
  def capitalize_sentence(text, delimiter \\ ". ") do
    text
    |> String.split(delimiter)
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(delimiter)
  end
end
