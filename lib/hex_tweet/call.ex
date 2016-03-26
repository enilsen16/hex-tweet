defmodule HexTweet.Call do
  use GenServer

  @time_to_subtract 30000 #millaseconds

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Process.send_after(self(), :work, @time_to_subtract)
    {:ok, state}
  end

  def handle_info(:work, state) do
    HexTweet.Run.execute(div(@time_to_subtract, 1000))
    Process.send_after(self(), :work, @time_to_subtract)
    {:noreply, state}
  end
end
