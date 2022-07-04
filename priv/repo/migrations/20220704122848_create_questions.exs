defmodule Pollpal.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :title, :string
      add :description, :string
      add :mode, :string
      add :ip_duplication, :boolean, default: false, null: false

      timestamps()
    end
  end
end
