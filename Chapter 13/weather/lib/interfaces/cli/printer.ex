defmodule Weather.Interfaces.CLI.Printer do
  def print({ :ok, report }) do
    IO.write '\n'
    IO.puts """
    ---+++---
    Report from: #{report.credit.name}
    Organization site: #{report.credit.url}
    Logo: #{report.image.url}

    ---+++---
    Location #{report.location}
    Station: #{report.station_id}
    latitude: #{report.latitude}
    longitude: #{report.longitude}
    Observation time: #{report.observation_time}
    Observation time RFC822: #{report.observation_time_rfc822}

    ---+++---
    Weather: #{report.weather}
    Relative Humidity: #{report.relative_humidity}
    Visibility MI: #{report.visibility_mi}

    ---+++---
    Wind

    #{report.wind.string}
    Direction: #{report.wind.dir}
    Degrees: #{report.wind.degrees}
    Velocity: #{report.wind.mph}/mph
    Gust Velocity: #{report.wind.gust_mph}/mph
    KT: #{report.wind.kt}
    Gust KT: #{report.wind.gust_kt}

    ---+++---
    Temperature

    #{report.temperature.string}
    Temp Fº: #{report.temperature.temp_f}
    Temp Cº: #{report.temperature.temp_c}

    ---+++---
    Pressure

    #{report.pressure.string}
    MB: #{report.pressure.mb}
    IN: #{report.pressure.in}

    ---+++---
    Dewpoint

    #{report.dewpoint.string}
    Dewpoint Fº: #{report.dewpoint.dew_f}
    Dewpoint Cº: #{report.dewpoint.dew_c}

    ---+++---
    Heat Index

    #{report.heat_index.string}
    Heat Fº: #{report.heat_index.heat_f}
    Heat Cº: #{report.heat_index.heat_c}

    ---+++---
    More information

    disclaimer: #{report.urls.disclaimer}
    copyright: #{report.urls.copyright_url}
    """
  end

  def print({ :error, reason }) do
    IO.puts "Error: #{reason}"
  end
end
