defmodule RumblWeb.VideosController do
  use RumblWeb, :controller

  alias Rumbl.Multimedia
  alias Rumbl.Multimedia.Videos

  def index(conn, _params) do
    videos = Multimedia.list_videos()
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    changeset = Multimedia.change_videos(%Videos{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"videos" => videos_params}) do
    case Multimedia.create_videos(videos_params) do
      {:ok, videos} ->
        conn
        |> put_flash(:info, "Videos created successfully.")
        |> redirect(to: Routes.videos_path(conn, :show, videos))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    videos = Multimedia.get_videos!(id)
    render(conn, "show.html", videos: videos)
  end

  def edit(conn, %{"id" => id}) do
    videos = Multimedia.get_videos!(id)
    changeset = Multimedia.change_videos(videos)
    render(conn, "edit.html", videos: videos, changeset: changeset)
  end

  def update(conn, %{"id" => id, "videos" => videos_params}) do
    videos = Multimedia.get_videos!(id)

    case Multimedia.update_videos(videos, videos_params) do
      {:ok, videos} ->
        conn
        |> put_flash(:info, "Videos updated successfully.")
        |> redirect(to: Routes.videos_path(conn, :show, videos))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", videos: videos, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    videos = Multimedia.get_videos!(id)
    {:ok, _videos} = Multimedia.delete_videos(videos)

    conn
    |> put_flash(:info, "Videos deleted successfully.")
    |> redirect(to: Routes.videos_path(conn, :index))
  end
end
