defmodule Portfolio.UserController do
  use Portfolio.Web, :controller

  alias Portfolio.User

  def new(conn, params) do
    user = conn.assigns.user.id
    changeable = User.changeset_preferences(Repo.get(User, user))
    render(conn, "preferences.html", changeset: changeable, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset_preferences(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "preferences.html", user: user, changeset: changeset)
    end
  end
end
