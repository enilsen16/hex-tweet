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
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :extwitter],
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
      {:httpoison, "~> 0.8.2"},
      {:oauth, github: "tim/erlang-oauth"},
      {:poison, "~> 2.0", override: true},
      {:exvcr, "~> 0.7", only: :test}
    ]
  end
end
