defmodule HexTweet.Call do
  use GenServer

  @time_to_subtract 30000 #millaseconds

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Process.send_after(self(), :work, 1000)
    {:ok, state}
  end

  def handle_info(:work, state) do
    HexTweet.Run.execute(3 * (60 * 60 * 1000))
    Process.send_after(self(), :work, 1000)
    {:noreply, state}
  end
end
