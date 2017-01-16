defmodule Portfolio.PostController do
  use Portfolio.Web, :controller

  alias Portfolio.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render conn, "index.html", posts: posts
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    render conn, "show.html", post: post
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{}, %{})
    render conn, "new.html", changeset: changeset
  end
  
  def create(conn, %{"post" => post}) do
    changeset = Post.changeset(%Post{}, post)
    
    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post Created")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html",  changeset: changeset
    end
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get(Post, id)
    changeset = Post.changeset(post)

    render conn, "edit.html", changeset: changeset, post: post
  end

  def update(conn, %{"id" => id, "post" => post}) do
    old_post = Repo.get(Post, id)
    changeset = Post.changeset(old_post, post)

    case Repo.update(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post Edited")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, post: old_post
    end
  end

  def delete(conn, %{"id" => id}) do
    Repo.get!(Post, id) |> Repo.delete!

    conn
    |> put_flash(:info, "Post deleted")
    |> redirect(to: post_path(conn, :index))
  end
end