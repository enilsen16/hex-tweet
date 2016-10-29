defmodule HexTweet.Run do
  alias HexTweet.{Parse, Tweet}
  alias Timex.{DateTime}
  use Timex

  def execute(time) do
    converted_time = Timex.shift(Timex.now, milliseconds: -time)
    body =
      "https://hex.pm/api/packages?sort=updated_at"
      |> Parse.get
      |> Parse.parse

    for package <- body do
      new_package? =
        package["updated_at"]
        |> add_timezone_to_timestamp
        |> Parse.convert_n_compare(converted_time)

      case new_package? do
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

  defp add_timezone_to_timestamp(timestamp) do
    case String.last(timestamp) do
      "Z" ->
        timestamp
      _ ->
        "#{timestamp}Z"
    end
  end
end
