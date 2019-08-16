defmodule Weather.Interfaces.CLI do
  @moduledoc """
  Handle command line parsing and dispatch to the
  processing pipeline.
  """

  alias Weather.App.Controllers.Forecast

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  defp parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                                     aliases:  [h:    :help])

    case parse do
      { [ help: true ], _, _ } -> :help
      { _, [ location ], _ } -> location
      _ -> :help
    end
  end

  defp process(:help) do
    IO.puts """
    usage: weather <location>
    """
  end

  defp process(location) do
    location
    |> Forecast.getWeather
  end
end
