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
      ip_duplication: question.ip_duplication
    }
  end
end
