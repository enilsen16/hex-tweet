defmodule HexTweet.Mixfile do
  use Mix.Project

  def project do
    [app: :hex_tweet,
     version: "0.0.1",
     elixir: "~> 1.6",
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
    [extra_applications: [:logger, :httpoison, :extwitter, :timex, :oauth],
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
      {:extwitter, "~> 0.6"},
      {:exvcr, "~> 0.7", only: :test},
      {:httpoison, "~> 1.0"},
      {:oauth, github: "tim/erlang-oauth"},
      {:timex, "~> 3.0"}
    ]
  end
end
