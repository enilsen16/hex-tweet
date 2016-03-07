defmodule HexTweet.Parse do
  use HTTPoison.Base

  def get(url) do
    HTTPoison.get(url)
  end
end
