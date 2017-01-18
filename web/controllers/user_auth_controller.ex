defmodule Portfolio.UserAuthController do
  use Portfolio.Web, :controller
  plug Ueberauth

  alias Portfolio.User
  alias Ueberauth.Strategy.Helpers

  def sign_out(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "Signed Out")
    |> redirect(to: post_path(conn, :index))
  end

  

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    # IO.inspect auth
    
    
    token = cond do
      is_list(auth.credentials.token) -> List.to_string(auth.credentials.token)
      true -> auth.credentials.token
    end
    user_params = %{token: token, email: auth.info.email, provider: Atom.to_string(auth.provider), username: auth.info.nickname, name: auth.info.name}

    changeset_from_oauth = User.changeset_from_oauth(%User{}, user_params)
    sign_in(conn, changeset_from_oauth)
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failure to Authenticate.")
    |> redirect(to: "/")
  end

  def sign_in(conn, changeset_from_oauth) do
    case insert_or_update_user(conn, changeset_from_oauth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Thanks for Signing Up!")
        |> put_session(:user_id, user.id)
        |> redirect(to: user_path(conn, :new))
      {:ok, :existing, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: post_path(conn, :index))
      {:error, reason} ->
        # IO.puts("-----")
        # IO.inspect(reason)
        # IO.puts("-----")
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: post_path(conn, :index))
    end
  end

  defp insert_or_update_user(conn, changeset_from_oauth) do
    # IO.inspect conn
    # IO.puts "^^^^^^^^^^^^^^^^"
    # IO.inspect changeset_from_oauth
    case Repo.get_by(User, username: changeset_from_oauth.changes.username) do
      nil ->
        Repo.insert(changeset_from_oauth)
      user ->
        {:ok, :existing, user}
    end
  end

end