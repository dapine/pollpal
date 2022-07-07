defmodule Pollpal.Repo.Migrations.AddUniquenessConstraintToIndexAtQuestionOptions do
  use Ecto.Migration

  def change do
		create unique_index(:question_options, [:index, :question_id])
  end
end
