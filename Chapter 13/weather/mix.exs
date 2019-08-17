defmodule Weather.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather,
      name: "Weather",
      url: "https://github.com/GArmane/programming-elixir/tree/master/Chapter%2013/weather",
      version: "0.1.0",
      elixir: "~> 1.8",
      escript: escript_config(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [ :logger, :httpoison ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :httpoison, "~> 1.5" },
      { :sweet_xml, "~> 0.6.6"}
    ]
  end

  defp escript_config do
    [ main_module: Weather ]
  end
end
