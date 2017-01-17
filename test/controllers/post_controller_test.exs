defmodule Portfolio.PostControllerTest do
  use Portfolio.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Posts"
  end

  test "GET /posts", %{conn: conn} do
    conn = get conn, "/posts"
    assert html_response(conn, 200) =~ "Posts"
  end

  @moduletag :login_redirects
  test "GET /posts/new without login redirects to /posts", %{conn: conn} do

    conn = get conn, "/posts/new"
    assert redirected_to(conn, 302) =~ "/posts"
  end

  @moduletag :login_redirects
  test "GET /posts/:id/edit without login redirects to /posts", %{conn: conn} do

    conn = get conn, "/posts/:id/edit", %{"id" => :id}
    assert redirected_to(conn, 302) =~ "/posts"
  end

  @moduletag :login_redirects
  test "DELETE /posts/:id without login redirects to /posts", %{conn: conn} do

    conn = delete conn, "/posts/:id", %{"id" => :id}
    assert redirected_to(conn, 302) =~ "/posts"
  end

  @moduletag :login_redirects
  test "POST /posts without login redirects to /posts", %{conn: conn} do

    conn = post conn, "/posts"
    assert redirected_to(conn, 302) =~ "/posts"
  end

  @moduletag :login_redirects
  test "PATCH /posts/:id without login redirects to /posts", %{conn: conn} do

    conn = patch conn, "/posts/:id", %{"id" => :id}
    assert redirected_to(conn, 302) =~ "/posts"
  end





  

end
