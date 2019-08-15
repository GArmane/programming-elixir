defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      version: "0.1.0",
      name: "Issues",
      source_url: "https://github.com/GArmane/programming-elixir/tree/master/Chapter%2013/issues",
      elixir: "~> 1.8",
      escript: escript_config(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :jsx]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :httpoison, "~> 0.4" },
      { :jsx,       "~> 2.0" },
      { :ex_doc,    github: "elixir-lang/ex_doc" },
    ]
  end

  defp escript_config do
    [ main_module: Issues.CLI ]
  end
end
