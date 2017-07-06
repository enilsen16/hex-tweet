defmodule HexTweet.Tweet do
  require Logger

  def build(structure) do
    tweet = "#{structure.name} (#{structure.version}): #{structure.description} #{structure.url}"
    if String.length(tweet) <= 140 do
      {:ok, tweet}
    else
      {:ok, _build(structure)}
    end
  end

  def post({:ok, tweet}) do
    ExTwitter.update(tweet)
    Logger.info(tweet)
  end

  defp _build(structure) do
    length = String.length("#{structure.name} (#{structure.version}): #{structure.url}")
    length_of_description = (140 - length) - 4
    <<string::binary-size(length_of_description), _::binary >> = structure.description
    string = String.trim(string)
    "#{structure.name} (#{structure.version}): #{string}... #{structure.url}"
  end
end
