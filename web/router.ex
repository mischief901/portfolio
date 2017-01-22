defmodule Portfolio.Router do
  use Portfolio.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Portfolio.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Portfolio do
    pipe_through :browser # Use the default browser stack

    get "/about", AboutController, :index
    get "/preferences", UserController, :preferences
    put "/preferences/:id", UserController, :update
    resources "/posts", PostController
    get "/", PostController, :index
  end

  scope "/auth", Portfolio do
    pipe_through :browser

    get "/new", UserAuthController, :sign_in
    get "/signout", UserAuthController, :sign_out
    get "/:provider", UserAuthController, :request
    get "/:provider/callback", UserAuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Portfolio do
  #   pipe_through :api
  # end
end
