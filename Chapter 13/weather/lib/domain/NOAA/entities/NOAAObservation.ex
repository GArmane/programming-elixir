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
    location: "",
    station_id: "",
    latitude: "",
    longitude: "",
    observation_time: "",
    observation_time_rfc822: "",
    weather: "",
    relative_humidity: 0,
    wind: %{
      string: nil,
      dir: nil,
      degrees: 0,
      mph: 0.0,
      gust_mph: 0.0,
      kt: 0,
      gust_kt: 0,
    },
    temperature: %{
      string: nil,
      temp_f: nil,
      temp_c: nil,
    },
    pressure: %{
      string: nil,
      mb: 0.0,
      in: 0.0
    },
    dewpoint: %{
      string: nil,
      dew_f: 0.0,
      dew_c: 0.0,
    },
    heat_index: %{
      string: nil,
      heat_f: 0.0,
      heat_c: 0.0,
    },
    visibility_mi: 0.0,
    urls: %{
      icon_url_base: "",
      two_day_history_url: "",
      icon_url_name: "",
      ob_url: "",
      disclaimer: "",
      copyright_url: "",
      privacy_policy_url: ""
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
        wind_string: ~x"./wind_string/text()"s,
        wind_dir: ~x"./wind_dir/text()"s,
        wind_degrees: ~x"./wind_degrees/text()"i,
        wind_mph: ~x"./wind_mph/text()"f,
        wind_gust_mph: ~x"./wind_gust_mph/text()"f,
        wind_kt: ~x"./wind_kt/text()"i,
        wind_gust_kt: ~x"./wind_gust_kt/text()"i,
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
end
