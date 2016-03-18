defmodule ParseTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest HexTweet

  setup_all do
    HTTPoison.start
  end

  test "returns a response from a given json api" do
    use_cassette "httpoison_get" do
      response = HexTweet.Parse.get("https://hex.pm/api/packages?sort=updated_at")
      assert {:ok, %HTTPoison.Response{status_code: 200, body: _body}} = response
    end
  end

  test "returns a parsed response" do
    use_cassette "httpoison_get" do
      response = HexTweet.Parse.get("https://hex.pm/api/packages?sort=updated_at")
      assert [%{}| _] = HexTweet.Parse.parse(response)
    end
  end

  test "sorts correctly based on updated_at" do
    use_cassette "httpoison_get" do
      response = HexTweet.Parse.get("https://hex.pm/api/packages?sort=updated_at")
                  |> HexTweet.Parse.parse
      result = HexTweet.Parse.sort(List.first(response))
      assert [%HexTweet.Parse{name: _, description: _, url: _, updated_at: _}] = result
    end
  end
end
