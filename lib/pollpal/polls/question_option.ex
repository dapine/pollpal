defmodule Pollpal.Polls.QuestionOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "question_options" do
    field :index, :integer
    field :value, :string

		belongs_to :question, Pollpal.Polls.Question

    timestamps()
  end

  @doc false
  def changeset(question_option, attrs) do
    question_option
    |> cast(attrs, [:value, :index])
    |> validate_required([:value, :index])
  end
end
