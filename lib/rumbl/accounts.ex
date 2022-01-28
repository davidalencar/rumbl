defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts context
  """

  alias Rumbl.Accounts.User

  def list_users() do 
    [
      %User{id: 1, name: "David", username: "davidalencar"},
      %User{id: 2, name: "Bruce", username: "brucealencar"},
      %User{id: 3, name: "José", username: "josevalim"},
    ]
  end

  def get_user(id) do
    list_users()
    |> Enum.find(fn %User{:id => user_id} -> 
      user_id == id
    end)
  end

  def get_user_by(params) do
    list_users()
    |> Enum.find(fn user ->
      Enum.all?(params, fn {key, val} ->
        Map.get(user, key) == val
      end)
    end)
  end
end
