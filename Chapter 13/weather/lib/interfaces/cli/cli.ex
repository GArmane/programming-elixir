defmodule Weather.Interfaces.CLI do
  alias Weather.Interfaces.CLI.Printer
  alias Weather.App.Controllers.Forecast

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

  def run(argv) do
    argv
    |> parse_args
    |> process
    |> Printer.print
  end
end
