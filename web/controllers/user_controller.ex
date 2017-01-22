defmodule Portfolio.UserController do
  use Portfolio.Web, :controller

  alias Portfolio.User

  def preferences(conn, _params) do
    user = conn.assigns.user.id
    changeset = User.changeset_from_oauth(conn.assigns.user)
    # from_oauth = conn.assigns.user
    # changeset = User.changeset_preferences(from_oauth)
    # IO.inspect(changeset)
    render(conn, "preferences.html", changeset: changeset, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset_preferences(user, user_params)

    case Repo.update(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Info updated successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "preferences.html", user: user, changeset: changeset)
    end
  end
end
