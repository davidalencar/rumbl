defmodule Rumbl.Multimedia.Videos do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    belongs_to :user, Rumbl.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(videos, attrs) do
    videos
    |> cast(attrs, [:url, :title, :description])
    |> validate_required([:url, :title, :description])
  end
end
