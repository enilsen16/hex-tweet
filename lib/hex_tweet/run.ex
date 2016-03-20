defmodule HexTweet.Run do
  alias HexTweet.{Parse, Tweet}
  use Timex

  def execute do
    body = "https://hex.pm/api/packages"
      |> Parse.get
      |> Parse.parse

    for package <- body do
      case Timex.diff(Time.now, package["updated_at"], :seconds) <= 30  do
        true ->
          IO.puts package
        _ ->
          IO.inspect Timex.diff(DateTime.now, package["updated_at"], :seconds)
      end
    end
  end
end
