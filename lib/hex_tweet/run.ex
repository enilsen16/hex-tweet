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
          Timex.after?(Timex.DateTime.today, updated_at)
      end
    end
  end
end
