defmodule Portfolio.PostController do
  use Portfolio.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(_conn, %{"id" => :id}) do
    
  end

  def new(_conn, _params) do

  end

  def delete(_conn, _params) do

  end
end