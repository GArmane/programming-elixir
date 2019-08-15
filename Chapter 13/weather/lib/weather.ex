defmodule Weather do
  @moduledoc """
  Weather application entry point.
  """

  @doc """
  Initializes the application

  ## Examples

      iex> Weather.start()

  """
  def main(argv) do
    Weather.Interfaces.CLI.run argv
  end
end
