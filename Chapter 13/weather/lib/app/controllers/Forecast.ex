defmodule Weather.App.Controllers.Forecast do
  alias Weather.Infra.Services.NOAAService, as: ForecastService

  def getWeather(location) do
    location
    |> ForecastService.fetch
  end
end
