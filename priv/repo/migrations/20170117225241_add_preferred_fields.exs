defmodule Portfolio.Repo.Migrations.AddPreferredFields do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :preferred_name, :string
      add :preferred_email, :string
      add :preferred_username, :string
    end

  end
end
