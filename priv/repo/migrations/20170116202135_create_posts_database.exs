defmodule Portfolio.Repo.Migrations.CreatePostsDatabase do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :string
      
      timestamps()
    end
  end
end
