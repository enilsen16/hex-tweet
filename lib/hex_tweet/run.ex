defmodule HexTweet.Run do
  alias HexTweet.{Parse, Tweet}
  use Timex

  def execute(time) do
    converted_time = Timex.shift(Timex.DateTime.now, milliseconds: -time)
    body = "https://hex.pm/api/packages?sort=updated_at"
      |> Parse.get
      |> Parse.parse

    for package <- body do
      case Timex.after?(Timex.parse!(package["updated_at"], "{ISO:Extended}"), converted_time)  do
        true ->
          tweet(package)
          IO.puts "#{package["name"]} updated!"
        _ ->
          :error
      end
    end
  end

  defp tweet(package) do
    case Parse.sort(package) do
      {:error, _} ->
        :error
      {:ok, tweet} ->
        tweet
        |> Tweet.build
        |> Tweet.post
    end
  end
end
