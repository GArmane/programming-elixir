defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: [BitString, List] do
  @alphabet "abcdefghijklmnopqrstuvwxyz"
    |> String.graphemes

  @cardinality @alphabet
    |> length

  @char_to_index @alphabet
    |> Enum.zip(0..@cardinality)
    |> Enum.reduce(%{}, fn {grapheme, index}, acc ->
        Map.merge(acc, %{ grapheme => index })
      end)

  @index_to_char 0..@cardinality
    |> Enum.zip(@alphabet)
    |> Enum.reduce(
      %{}, fn {index, grapheme}, acc ->
        Map.merge(acc, %{ index => grapheme })
      end)

  defp calc_new_index(code_point, times),
  do: rem(code_point + times, @cardinality)

  defp get_index(char),
  do: @char_to_index[char]

  defp get_char(index),
  do: @index_to_char[index]

  defp shift(char, times) do
    char
    |> get_index
    |> calc_new_index(times)
    |> get_char
  end

  def encrypt(string, times) when is_bitstring(string) do
    string
    |> String.graphemes
    |> encrypt(times)
    |> Enum.join
  end

  def encrypt(list, times) do
    list
    |> Enum.map(&(shift(&1, times)))
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end
