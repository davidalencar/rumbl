defmodule Rumbl.MultimediaTest do
  use Rumbl.DataCase

  alias Rumbl.Multimedia

  describe "videos" do
    alias Rumbl.Multimedia.Videos

    import Rumbl.MultimediaFixtures

    @invalid_attrs %{description: nil, title: nil, url: nil}

    test "list_videos/0 returns all videos" do
      videos = videos_fixture()
      assert Multimedia.list_videos() == [videos]
    end

    test "get_videos!/1 returns the videos with given id" do
      videos = videos_fixture()
      assert Multimedia.get_videos!(videos.id) == videos
    end

    test "create_videos/1 with valid data creates a videos" do
      valid_attrs = %{description: "some description", title: "some title", url: "some url"}

      assert {:ok, %Videos{} = videos} = Multimedia.create_videos(valid_attrs)
      assert videos.description == "some description"
      assert videos.title == "some title"
      assert videos.url == "some url"
    end

    test "create_videos/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Multimedia.create_videos(@invalid_attrs)
    end

    test "update_videos/2 with valid data updates the videos" do
      videos = videos_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", url: "some updated url"}

      assert {:ok, %Videos{} = videos} = Multimedia.update_videos(videos, update_attrs)
      assert videos.description == "some updated description"
      assert videos.title == "some updated title"
      assert videos.url == "some updated url"
    end

    test "update_videos/2 with invalid data returns error changeset" do
      videos = videos_fixture()
      assert {:error, %Ecto.Changeset{}} = Multimedia.update_videos(videos, @invalid_attrs)
      assert videos == Multimedia.get_videos!(videos.id)
    end

    test "delete_videos/1 deletes the videos" do
      videos = videos_fixture()
      assert {:ok, %Videos{}} = Multimedia.delete_videos(videos)
      assert_raise Ecto.NoResultsError, fn -> Multimedia.get_videos!(videos.id) end
    end

    test "change_videos/1 returns a videos changeset" do
      videos = videos_fixture()
      assert %Ecto.Changeset{} = Multimedia.change_videos(videos)
    end
  end
end
