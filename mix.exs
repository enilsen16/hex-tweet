defmodule HexTweet.Mixfile do
  use Mix.Project

  def project do
    [app: :hex_tweet,
     version: "0.0.1",
     elixir: "~> 1.2",
     preferred_cli_env: [
       vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test
     ],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :extwitter, :timex, :sasl],
     mod: {HexTweet, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_rfc3986, "~> 0.2.7"},
      {:extwitter, "~> 0.6"},
      {:exvcr, "~> 0.7", only: :test},
      {:httpoison, "~> 0.8"},
      {:oauth, github: "tim/erlang-oauth"},
      {:timex, "~> 3.0"}
    ]
  end
end
