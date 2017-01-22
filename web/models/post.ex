defmodule Portfolio.Post do
  use Portfolio.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string
    belongs_to :user, Portfolio.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :content])
    |> validate_required([:title])
  end

end