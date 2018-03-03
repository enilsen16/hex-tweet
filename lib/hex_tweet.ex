defmodule HexTweet do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: HexTweet.Worker.start_link(arg1, arg2, arg3)
      # worker(HexTweet.Worker, [arg1, arg2, arg3]),
      worker(HexTweet.Call, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HexTweet.Supervisor]

    IO.puts System.get_env("TWITTER_CONSUMER_KEY")
    IO.puts System.get_env("TWITTER_CONSUMER_SECRET")
    IO.puts System.get_env("TWITTER_ACCESS_TOKEN")
    IO.puts System.get_env("TWITTER_ACCESS_SECRET")
    
    Supervisor.start_link(children, opts)
  end
end
