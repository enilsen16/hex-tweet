defmodule HexTweet.Call do
  alias HexTweet.Run
  use GenServer

  @time_to_subtract 60000 # millaseconds

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Process.send_after(self(), :work, @time_to_subtract)
    {:ok, state}
  end

  def handle_info(:work, state) do
    Run.execute(@time_to_subtract)
    Process.send_after(self(), :work, @time_to_subtract)
    {:noreply, state}
  end
end
