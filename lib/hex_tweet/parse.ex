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

  defp get_version(body) do
    versions = "https://hex.pm/api/packages/#{body["name"]}"
      |> get
      |> parse

    if Map.has_key?(versions, "releases") && versions["releases"] == [] do
        {:error, "error"}
    else
      case parse_release(versions) do
        :error ->
          {:error, "error"}
        version ->
          {:ok, version}
      end
    end
  end

  defp parse_release(body) do
    release = List.first(body["releases"])
    time = Timex.shift(Timex.DateTime.now, milliseconds: -70000)

    if convert_n_compare(release["inserted_at"], time) do
      release["version"]
    else
      :error
    end
  end

  def convert_n_compare(time, current_time) do
    time
    |> Timex.parse!("{ISO:Extended:Z}")
    |> Timex.after?(current_time)
  end
end
