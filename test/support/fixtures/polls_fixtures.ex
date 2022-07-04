defmodule Pollpal.PollsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pollpal.Polls` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        description: "some description",
        ip_duplication: true,
        mode: :multiple,
        title: "some title"
      })
      |> Pollpal.Polls.create_question()

    question
  end
end
