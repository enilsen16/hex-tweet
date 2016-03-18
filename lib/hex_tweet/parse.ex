defmodule HexTweet.Parse do
  use HTTPoison.Base

  defstruct [:name, :description, :url, :updated_at]

  def get(url) do
    HTTPoison.get(url)
  end

  def parse({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Poison.Parser.parse!(body)
  end

  def sort(body) when is_map(body) do
    [%HexTweet.Parse{name: body["meta"]["name"], description: body["meta"]["description"],
    url: body[:url], updated_at: body["updated_at"]}]
  end
end
