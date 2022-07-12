defmodule Pollpal.Polls.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :description, :string
    field :ip_duplication_check, :boolean, default: false
    field :mode, Ecto.Enum, values: [:multiple, :exclusive], default: :exclusive
    field :title, :string

    has_many :question_options, Pollpal.Polls.QuestionOption

    has_many :votes, Pollpal.Polls.Vote

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:title, :description, :mode, :ip_duplication_check])
    |> validate_required([:title])
    |> cast_assoc(:question_options,
      with: &Pollpal.Polls.QuestionOption.changeset/2,
      required: false
    )
  end
end
