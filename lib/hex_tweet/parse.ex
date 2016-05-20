defmodule HexTweet.Parse do
  alias HexTweet.Parse
  alias Poison.Parser

  use HTTPoison.Base

  defstruct [:name, :version, :description, :url, :updated_at]

  def get(url) do
    headers = [{"Cache-Control", "no-cache"}, {"Pragma", "no-cache"}, {"Host", "hex.pm"}]
    HTTPoison.get(url, headers)
  end

  def parse({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Parser.parse!(body)
  end

  def sort(body) when is_map(body) do
    case get_version(body) do
    {:error, _} ->
      {:error, "error"}
    {:ok, version} ->
      tweet = %Parse{name: body["name"], version: version, description: body["meta"]["description"],
      url: body["url"], updated_at: body["updated_at"]}
      {:ok, tweet}
    end
  end

  # Temporary
  defp get_version(body) do
    versions = "https://hex.pm/api/packages/#{body["name"]}"
      |> get
      |> parse

    if Map.has_key?(versions, "releases") && versions["releases"] == [] do
        {:error, "error"}
    else
        version =
          versions
          |> parse_release
        {:ok, version}
    end
  end

  defp parse_release(body) do
    List.first(body["releases"])["version"]
  end
end
