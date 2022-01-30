defmodule Rumbl.Multimedia.Videos do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string

    belongs_to :user, Rumbl.Accounts.User
    belongs_to :category, Rumbl.Multimedia.Category

    timestamps()
  end

  @doc false
  def changeset(videos, attrs) do
    videos
    |> cast(attrs, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
  end
end
