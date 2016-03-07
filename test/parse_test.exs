defmodule ParseTest do
  use ExUnit.Case
  doctest HexTweet

  test "returns a response from a given json api" do
    response = HexTweet.Parse.get("https://hex.pm/api/packages?sort=updated_at")
    assert {:ok, %HTTPoison.Response{status_code: 200, body: body}} = response
  end
end
