defmodule Weather.Infra.Services.NOAAService do
  @user_agent [ {"User-Agent", "HTTPoison"} ]

  defp build_url(location) do
    "https://w1.weather.gov/xml/current_obs/#{location}.xml"
  end

  defp handle_response({ :ok, %HTTPoison.Response{ status_code: 200, body: response }}) do
    {:ok, response }
  end

  defp handle_response({ :ok, %HTTPoison.Response{ status_code: 404 }}) do
    {:error, reason: "Location not found" }
  end

  defp handle_response({ :ok, %HTTPoison.Response{ status_code: status }}) do
    {:error, reason: "Server responded with #{status}" }
  end

  defp handle_response({ :error, %HTTPoison.Error{ reason: reason } }) do
    {:error, reason }
  end

  def fetch(location) do
    location
    |> build_url
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end
end
