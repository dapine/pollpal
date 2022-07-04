defmodule Pollpal.Polls.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :description, :string
    field :ip_duplication, :boolean, default: false
    field :mode, Ecto.Enum, values: [:multiple, :exclusive]
    field :title, :string

		has_many :question_options, Pollpal.Polls.QuestionOption

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:title, :description, :mode, :ip_duplication])
    |> validate_required([:title, :description, :mode, :ip_duplication])
  end
end
