defmodule RumblWeb.VideosChannel do
  use RumblWeb, :channel

  @impl true
  def join("videos:" <> video_id , _payload, socket) do
      {:ok, assign(socket, :video_id, String.to_integer(video_id))}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (videos:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

end
