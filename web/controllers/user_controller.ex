defmodule Portfolio.UserController do
  use Portfolio.Web, :controller

  alias Portfolio.User

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render conn, "new.html", changeset: changeset
  end

end