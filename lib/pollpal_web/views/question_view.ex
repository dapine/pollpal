defmodule PollpalWeb.QuestionView do
  use PollpalWeb, :view
  alias PollpalWeb.QuestionView

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: render_one(question, QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    %{
      id: question.id,
      title: question.title,
      description: question.description,
      mode: question.mode,
      ip_duplication_check: question.ip_duplication_check
    }
  end

  def render("question_basic.json", %{question: question}) do
    %{
      title: question.title,
      description: question.description
    }
  end

  def render("question_options.json", %{question_options: question_options}) do
    %{data: Enum.map(question_options, fn qo -> %{value: qo.value, index: qo.index} end)}
  end

  def render("question_option.json", %{question_option: question_option}) do
    %{
      data: %{
        index: question_option.index,
        value: question_option.value
      }
    }
  end

  def render("vote.json", %{vote: vote}) do
    %{
      data: %{
        question: vote.question_id,
        question_option: vote.question_option_id
      }
    }
  end

  def render("results.json", %{question: question, votes: votes}) do
    %{
      data: %{
        question: render_one(question, QuestionView, "question_basic.json"),
        results: Enum.map(votes, fn {num, option} -> %{numberOfVotes: num, option: option} end)
      }
    }
  end
end
