defmodule TweetTest do
  use ExUnit.Case
  doctest HexTweet

  test "crafts a tweet correctly" do
    struct = %HexTweet.Parse{name: "ExTwitter", description: "Twitter client library for elixir.", url: "https://hex.pm/packages/extwitter", version: "0.6.3", updated_at: nil}
    result = HexTweet.Tweet.build(struct)
    assert {:ok, tweet} = result
    assert String.length(tweet) <= 158
    assert tweet == "ExTwitter (0.6.3): Twitter client library for elixir. https://hex.pm/packages/extwitter"
  end

  test "truncates a tweet if it is greater than 160 chars" do
    struct = %HexTweet.Parse{name: "poolboy", description: "A hunky Erlang worker pool factory. This is an example application showcasing database connection pools using Poolboy and epgsql. ", url: "https://hex.pm/packages/poolboy", version: "1.5.1", updated_at: nil}
    result = HexTweet.Tweet.build(struct)
    assert {:ok, tweet} = result
    assert tweet == "poolboy (1.5.1): A hunky Erlang worker pool factory. This is an example application showcasing database c... https://hex.pm/packages/poolboy"
    assert String.length(tweet) <= 158
  end
end
