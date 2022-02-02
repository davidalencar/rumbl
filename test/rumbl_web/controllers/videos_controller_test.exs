defmodule VideosControllerTest do
  use RumblWeb.ConnCase, async: true

  test "require user authentication on all actions", %{conn: conn} do
    [get(conn, Routes.videos_path(conn, :new)),
      get(conn, Routes.videos_path(conn, :index)),
      get(conn, Routes.videos_path(conn, :show, "123")),
      get(conn, Routes.videos_path(conn, :edit, "123")),
      put(conn, Routes.videos_path(conn, :update, "123", %{})),
      post(conn, Routes.videos_path(conn, :create, %{})),
      delete(conn, Routes.videos_path(conn, :delete, "123"))]
      |> Enum.each(fn conn ->
        assert html_response(conn, 302)
        assert conn.halted
      end)



  end
  
end
