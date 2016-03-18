defmodule HexTweet.Tweet do

  def build(structure) when is_map(structure) do
    tweet = "#{structure.name}(#{structure.version}): #{structure.description}\n#{structure.url}"
    case String.length(tweet) <= 160 do
      true ->
        tweet
    end
  end

  def post(tweet) do

  end
end
