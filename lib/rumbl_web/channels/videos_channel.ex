defmodule RumblWeb.VideosChannel do
  use RumblWeb, :channel

  @impl true
  def join("videos:" <> video_id , _payload, socket) do
      {:ok, assign(socket, :video_id, String.to_integer(video_id))}
  end

  def handle_info(:ping, socket) do
    count = socket.assigns[:count] || 1
    push(socket, "ping", %{count: count})
    {:noreply, assign(socket, :count, count + 1)}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("new_annotation", payload, socket) do
    broadcast!(socket, "new_annotation", %{
      user: %{username: "anon"},
      body: payload["body"],
      at: payload["at"]
    })
    {:reply, :ok, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (videos:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

end
