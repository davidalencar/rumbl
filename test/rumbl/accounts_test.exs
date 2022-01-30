defmodule Rumbl.AccountsTest do
  use Rumbl.DataCase, async: true

  alias Rumbl.{Accounts, Accounts.User}

  describe "register_user/1" do
    @valid_attrs %{
      name: "David",
      username: "davidalencar",
      password: "secret"}

    @invalid_attrs %{}

    test "with valid data innserts user" do
      assert {:ok, %User{id: id} = user} =
        Accounts.register_user(@valid_attrs)

      assert user.name == "David"
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "with invalid data does not insert user" do
      assert {:error, _changeset} = 
        Accounts.register_user(@invalid_attrs)

      assert Accounts.list_users() == []
    end

    test "enforces unique username" do
      assert {:ok, %User{id: id}} = Accounts.register_user(@valid_attrs)
      assert {:error, changeset} = Accounts.register_user(@valid_attrs)

      assert %{username: ["has already been taken"]} = errors_on(changeset);
      assert [%User{id: ^id}] = Accounts.list_users()
    end
    
    test "does not accept long usernames" do
      attrs = Map.put(@valid_attrs, :username, String.duplicate("d", 30))
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{username: ["should be at most 20 character(s)"]} = errors_on(changeset)
    end

    test "requires password to be at least 6 chars long" do
      attrs = Map.put(@valid_attrs, :password, "12345")
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{password: ["should be at least 6 character(s)"]} = errors_on(changeset)

      assert Accounts.list_users() == []
    end
  end
end
