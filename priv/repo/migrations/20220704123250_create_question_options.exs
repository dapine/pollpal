defmodule Pollpal.Repo.Migrations.CreateQuestionOptions do
  use Ecto.Migration

  def change do
    create table(:question_options) do
      add :value, :string
      add :index, :integer
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:question_options, [:question_id])
  end
end
