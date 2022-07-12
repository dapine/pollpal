defmodule Pollpal.Polls.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :remote_ip_address, :string

    belongs_to :question, Pollpal.Polls.Question
    belongs_to :question_option, Pollpal.Polls.QuestionOption

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:remote_ip_address])
    |> validate_required([:remote_ip_address])
  end
end
