defmodule HexTweet.Tweet do

  def build(structure) do
    tweet = "#{structure.name} (#{structure.version}): #{structure.description} #{structure.url}"
    if String.length(tweet) <= 158 do
      {:ok, tweet}
    else
      {:ok, _build(structure)}
    end
  end

  def post({:ok, tweet}) do
    IO.puts tweet
    ExTwitter.update(tweet)
  end

  defp _build(structure) do
    length = String.length("#{structure.name} (#{structure.version}): #{structure.url}")
    length_of_description = (158 - length) - 4
    <<string::binary-size(length_of_description), _::binary >> = structure.description
    string = String.strip(string)
    "#{structure.name} (#{structure.version}): #{string}... #{structure.url}"
  end
end
