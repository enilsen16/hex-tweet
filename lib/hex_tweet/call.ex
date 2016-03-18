defmodule HexTweet.Call do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Process.send_after(self(), :work, 10000)
    {:ok, state}
  end

  def handle_info(:work, state) do
    #Do work here
    Process.send_after(self(), :work, 10000)
    {:noreply, state}
  end
end
