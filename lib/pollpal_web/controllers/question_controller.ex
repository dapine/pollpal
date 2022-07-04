defmodule PollpalWeb.QuestionController do
  use PollpalWeb, :controller

  alias Pollpal.Polls
  alias Pollpal.Polls.Question

  action_fallback PollpalWeb.FallbackController

  def index(conn, _params) do
    questions = Polls.list_questions()
    render(conn, "index.json", questions: questions)
  end

  def create(conn, %{"question" => question_params}) do
    with {:ok, %Question{} = question} <- Polls.create_question(question_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.question_path(conn, :show, question))
      |> render("show.json", question: question)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Polls.get_question!(id)
    render(conn, "show.json", question: question)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Polls.get_question!(id)

    with {:ok, %Question{} = question} <- Polls.update_question(question, question_params) do
      render(conn, "show.json", question: question)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Polls.get_question!(id)

    with {:ok, %Question{}} <- Polls.delete_question(question) do
      send_resp(conn, :no_content, "")
    end
  end

	def get_question_options(conn, %{"id" => id}) do
		question = Polls.get_question_with_options(id)
		render(conn, "question_options.json", question: question)
	end
end
