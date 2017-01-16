defmodule Portfolio.User do
  use Portfolio.Web, :model


  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :token, :string
    field :provider, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username])
    |> validate_required([:name, :username])
  end

end