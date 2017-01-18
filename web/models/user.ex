defmodule Portfolio.User do
  use Portfolio.Web, :model

  alias Ueberauth.Auth


  schema "users" do
    field :name, :string
    field :preferred_name, :string
    field :username, :string
    field :preferred_username, :string
    field :token, :string
    field :provider, :string
    field :email, :string
    field :preferred_email, :string
    has_many :posts, Portfolio.Post

    timestamps()
  end

  def changeset_from_oauth(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username, :provider, :token, :email])
    |> validate_required([:name, :username, :provider, :token])
  end

  def changeset_preferences(struct, params \\ %{}) do
    struct
    |> cast(params, [:preferred_name, :preferred_username, :preferred_email, :email])
    |> validate_required([:email])
  end


end