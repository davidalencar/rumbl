defmodule Rumbl.MultimediaTest do
  use Rumbl.DataCase, async: true

  alias Rumbl.{Multimedia, Multimedia.Videos}

  describe "categories" do
    test "list_alphabetical_categories/0" do
      ~w(Drama Action Comedy)
      |> Enum.map(&( Multimedia.create_category!(&1)))        


      assert ~w(Action Comedy Drama) =
          Multimedia.list_alphabetical_categories()
        |> Enum.map(&(&1.name))
    end
  end
  
  describe "videos" do 
    @valid_attrs %{description: "desc", title: "title", url: "url"}
    @invalid_attrs %{description: nil, title: nil, url: nil}

    test "list_videos/0 return all videos" do 
      ownenr = user_fixture()
      %Videos{id: id1} =  videos_fixture(ownenr, @valid_attrs)

      assert [%Videos{id: ^id1}] = Multimedia.list_videos()
    end
  end
end
