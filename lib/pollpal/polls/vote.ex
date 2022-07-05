defmodule Pollpal.Polls.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :question_id, :id
    field :question_option_id, :id

    belongs_to :questions, Pollpal.Polls.Question, primary_key: true
    belongs_to :question_options, Pollpal.Polls.QuestionOption, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [])
    |> validate_required([])
  end
end
