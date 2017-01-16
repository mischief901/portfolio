defmodule Portfolio.UserAuthController do
  use Portfolio.Web, :controller
  plug Ueberauth

  alias Portfolio.User

  def sign_out(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "Signed Out")
    |> redirect(to: post_path(conn, :index))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IO.puts("++++++++++++++")
    IO.inspect(conn.assigns.ueberauth_auth.info)

    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github", username: auth.info.nickname, name: auth.info.name}

    changeset = User.changeset(%User{}, user_params)
    sign_in(conn, changeset)
  end

  def sign_in(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: post_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: post_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end

end