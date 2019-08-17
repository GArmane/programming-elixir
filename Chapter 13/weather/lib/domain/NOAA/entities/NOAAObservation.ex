defmodule Weather.Domain.NOAA.Entities.Observation do
  import SweetXml

  defstruct [
    credit: %{
      name: nil,
      url: nil,
    },
    image: %{
      url: nil,
      title: nil,
      link: nil,
    },
    suggested_pickup: nil,
    suggested_pickup_period: nil,
    location: nil,
    station_id: nil,
    latitude: nil,
    longitude: nil,
    observation_time: nil,
    observation_time_rfc822: nil,
    weather: nil,
    relative_humidity: nil,
    wind: %{
      string: nil,
      dir: nil,
      degrees: nil,
      mph: nil,
      gust_mph: nil,
      kt: nil,
      gust_kt: nil,
    },
    temperature: %{
      string: nil,
      temp_f: nil,
      temp_c: nil,
    },
    pressure: %{
      string: nil,
      mb: nil,
      in: nil
    },
    dewpoint: %{
      string: nil,
      dew_f: nil,
      dew_c: nil,
    },
    heat_index: %{
      string: nil,
      heat_f: nil,
      heat_c: nil,
    },
    visibility_mi: nil,
    urls: %{
      icon_url_base: nil,
      two_day_history_url: nil,
      icon_url_name: nil,
      ob_url: nil,
      disclaimer: nil,
      copyright_url: nil,
      privacy_policy_url: nil,
    },
  ]

  def xml_mapping() do
    [
      current_observation: [
        ~x"/current_observation"l,
        credit: ~x"./credit/text()"s,
        credit_URL: ~x"./credit_URL/text()"s,
        image: [
          ~x"./image",
          url: ~x"./url/text()"s,
          title: ~x"./title/text()"s,
          link: ~x"./link/text()"s,
        ],
        suggested_pickup: ~x"./suggested_pickup/text()"s,
        suggested_pickup_period: ~x"./suggested_pickup_period/text()"s,
        location: ~x"./location/text()"s,
        station_id: ~x"./station_id/text()"s,
        latitude: ~x"./latitude/text()"s,
        longitude: ~x"./logitude/text()"s,
        observation_time: ~x"./observation_time/text()"s,
        observation_time_rfc822: ~x"./observation_time_rfc822/text()"s,
        weather: ~x"./weather/text()"s,
        temperature_string: ~x"./temperature_string/text()"s,
        temp_f: ~x"./temp_f/text()"s,
        temp_c: ~x"./temp_c/text()"s,
        relative_humidity: ~x"./relative_humidity/text()"i,
        wind_string: ~x"./wind_string/text()"So,
        wind_dir: ~x"./wind_dir/text()"So,
        wind_degrees: ~x"./wind_degrees/text()"Io,
        wind_mph: ~x"./wind_mph/text()"Fo,
        wind_gust_mph: ~x"./wind_gust_mph/text()"Fo,
        wind_kt: ~x"./wind_kt/text()"Io,
        wind_gust_kt: ~x"./wind_gust_kt/text()"Io,
        pressure_string: ~x"./pressure_string/text()"s,
        pressure_mb: ~x"./pressure_mb/text()"f,
        pressure_in: ~x"./pressure_in/text()"f,
        dewpoint_string: ~x"./dewpoint_string/text()"s,
        dewpoint_f: ~x"./dewpoint_f/text()"f,
        dewpoint_c: ~x"./dewpoint_c/text()"f,
        heat_index_string: ~x"./heat_index_string/text()"So,
        heat_index_f: ~x"./heat_index_f/text()"Fo,
        heat_index_c: ~x"./heat_index_c/text()"Fo,
        visibility_mi: ~x"./visibility_mi/text()"f,
        icon_url_base: ~x"./icon_url_base/text()"s,
        two_day_history_url: ~x"./two_day_history_url/text()"s,
        icon_url_name: ~x"./icon_url_name/text()"s,
        ob_url: ~x"./ob_url/text()"s,
        disclaimer: ~x"./disclaimer/text()"s,
        copyright_url: ~x"./copyright_url/text()"s,
        privacy_policy_url: ~x"./privacy_policy_url/text()"s,
      ]
    ]
  end

  def from_mapping(%{ current_observation: [ map ] }, :xml) do
    %Weather.Domain.NOAA.Entities.Observation{
      credit: %{
        name: map[:credit],
        url: map[:credit_URL],
      },
      image: map[:image],
      suggested_pickup: map[:suggested_pickup],
      suggested_pickup_period: map[:suggested_pickup_period],
      location: map[:location],
      station_id: map[:station_id],
      latitude: map[:latitude],
      longitude: map[:longitude],
      observation_time: map[:observation_time],
      observation_time_rfc822: map[:observation_time_rfc822],
      weather: map[:weather],
      relative_humidity: map[:relative_humidity],
      wind: %{
        string: map[:wind_string],
        dir: map[:wind_dir],
        degrees: map[:wind_degrees],
        mph: map[:wind_mph],
        gust_mph: map[:wind_gust_mph],
        kt: map[:wind_kt],
        gust_kt: map[:wind_gust_kt],
      },
      temperature: %{
        string: map[:temperature_string],
        temp_f: map[:temperature_temp_f],
        temp_c: map[:temperature_temp_c],
      },
      pressure: %{
        string: map[:pressure_string],
        mb: map[:pressure_mb],
        in: map[:pressure_in],
      },
      dewpoint: %{
        string: map[:dewpoint_string],
        dew_f: map[:dewpoint_f],
        dew_c: map[:dewpoint_c],
      },
      heat_index: %{
        string: map[:heat_index_string],
        heat_f: map[:heat_index_f],
        heat_c: map[:heat_index_c],
      },
      visibility_mi: map[:visibulity_mi],
      urls: %{
        icon_url_base: map[:icon_url_base],
        two_day_history_url: map[:two_day_history_url],
        icon_url_name: map[:icon_url_name],
        ob_url: map[:ob_url],
        disclaimer: map[:disclaimer],
        copyright_url: map[:copyright],
        privacy_policy_url: map[:privacy_policy_url],
      },
    }
  end
end
