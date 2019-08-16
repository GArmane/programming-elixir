defmodule Weather.App.Controllers.Forecast do
  alias Weather.App.Parsers.XMLParser
  alias Weather.Infra.Services.NOAAService, as: ForecastService

  defp handle_response({ :ok, response }) do
    response
    |> XMLParser.parse
  end

  defp handle_response(response), do: response

  def getWeather(location) do
    location
    |> ForecastService.fetch
    |> handle_response
  end
end
