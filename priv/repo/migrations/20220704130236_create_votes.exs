defmodule Pollpal.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :question_id, references(:questions, on_delete: :nothing)
      add :question_option_id, references(:question_options, on_delete: :nothing)

      timestamps()
    end

    create index(:votes, [:question_id])
    create index(:votes, [:question_option_id])
  end
end
