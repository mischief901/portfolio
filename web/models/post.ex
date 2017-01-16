defmodule Portfolio.Post do
  use Portfolio.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end

end