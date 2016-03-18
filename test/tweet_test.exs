defmodule TweetTest do
  use ExUnit.Case
  doctest HexTweet

  test "crafts a tweet correctly" do
    struct = %HexTweet.Parse{name: "ExTwitter", description: "Twitter client library for elixir.",
                            url: "https://hex.pm/packages/extwitter", version: "0.6.3", updated_at: nil}

    assert HexTweet.Tweet.build(struct) ==
    "ExTwitter(0.6.3): Twitter client library for elixir.\nhttps://hex.pm/packages/extwitter"
  end
end
