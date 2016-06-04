defmodule HexTweet.Run do
  alias HexTweet.{Parse, Tweet}
  alias Timex.{DateTime}
  use Timex

  def execute(time) do
    converted_time = Timex.shift(Timex.DateTime.now, milliseconds: -time)
    body =
      "https://hex.pm/api/packages?sort=updated_at"
      |> Parse.get
      |> Parse.parse

    for package <- body do
      case Timex.after?(Timex.parse!("#{package["updated_at"]}Z", "{ISO:Extended:Z}"), converted_time)  do
        true ->
          tweet(package)
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
