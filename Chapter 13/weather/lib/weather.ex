defmodule Weather do
  @moduledoc """
  Weather application entry point.
  """

  alias Weather.Interfaces.CLI

  @doc """
  Initializes the application

  ## Examples

      iex> Weather.start()

  """
  def main(argv) do
    argv
    |> CLI.run
  end
end
