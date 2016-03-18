defmodule HexTweet.Parse do
  use HTTPoison.Base

  def get(url) do
    HTTPoison.get(url)
  end

  def parse({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Poison.Parser.parse!(body)
  end
end
