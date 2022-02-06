defmodule RumblWeb.VideosChannel do
  use RumblWeb, :channel

  alias Rumbl.{Accounts, Multimedia}

  @impl true
  def join("videos:" <> video_id , _payload, socket) do
    video_id = String.to_integer(video_id)
    video = Multimedia.get_videos!(video_id)

    annotations = video
                  |> Multimedia.list_annotations()
                  |> Phoenix.View.render_many(RumblWeb.AnnotationView, "annotation.json")

      {:ok,%{annotations: annotations}, assign(socket, :video_id, video_id)}
  end


  @impl true
  def handle_in(event, payload, socket) do
    user = Accounts.get_user!(socket.assigns.user_id)
    handle_in(event, payload, user,socket)
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("new_annotation", payload, user, socket) do
    case Multimedia.annotate_video(user, socket.assigns.video_id, payload) do
      {:ok, annotation} ->
        broadcast!(socket, "new_annotation", %{
          id: annotation.id,
          user: RumblWeb.UserView.render("user.json", %{user: user}),
          body: annotation.body,
          at: annotation.at
        })

        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
