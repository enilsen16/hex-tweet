defmodule HexTweet.Parse do
  use HTTPoison.Base

  defstruct [:name, :version, :description, :url, :updated_at]

  def get(url) do
    HTTPoison.get(url)
  end

  def parse({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Poison.Parser.parse!(body)
  end

  def sort(body) when is_map(body) do
    name = body["name"]
    [%HexTweet.Parse{name: name, version: get_version(name), description: body["meta"]["description"],
    url: body[:url], updated_at: body["updated_at"]}]
  end

  # Temporary
  defp get_version(name) do
    "https://hex.pm/api/packages/#{name}"
      |> get
      |> parse
      |> parse_release
  end

  defp parse_release(body) do
    List.first(body["releases"])["version"]
  end
end
