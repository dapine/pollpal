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

  @doc """
  Generate a question with question options.
  """
  def question_fixture_with_options(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        description: "some description",
        ip_duplication: true,
        mode: :multiple,
        title: "some title"
      })
      |> Pollpal.Polls.create_question()

    qo1 =
      Ecto.build_assoc(question, :question_options, %{
        index: 1,
        value: "option 1"
      })

    qo2 =
      Ecto.build_assoc(question, :question_options, %{
        index: 2,
        value: "option 2"
      })

    Pollpal.Repo.insert!(qo1)
    Pollpal.Repo.insert!(qo2)

    question |> Pollpal.Repo.preload(:question_options)
  end
end
