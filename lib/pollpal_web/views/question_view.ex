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

	def render("question_options.json", %{question: question}) do
		%{data: Enum.map(question.question_options, fn qo -> %{value: qo.value, index: qo.index} end)}
	end
end
