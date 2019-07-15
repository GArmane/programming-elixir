defmodule MyModule do
  def ok!(pattern) do
    case pattern do
      {:ok, data} -> data
      {:error, reason} -> raise "Failed with reason: #{reason}"
    end
  end
end
