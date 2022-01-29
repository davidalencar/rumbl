defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  alias Rumbl.Accounts

  def index(conn, _params) do
    render(conn, "index.html", users: Accounts.list_users())
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", user: Accounts.get_user(id))
  end

  def new(conn, _params) do 
    chengeset = Accounts.change_user(%Accounts.User{})
    render(conn, "new.html", changeset: chengeset)
  end

  def create(conn, %{"user" => user_params}) do
    {:ok, user} = Accounts.create_user(user_params)

    conn
    |> put_flash(:info, "#{user.name} created!")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
