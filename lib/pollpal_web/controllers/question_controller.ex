defmodule PollpalWeb.QuestionController do
  use PollpalWeb, :controller

  alias Pollpal.Polls
  alias Pollpal.Polls.Question
  alias Pollpal.Polls.QuestionOption
  alias Pollpal.Polls.Vote

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
    render(conn, "question_options.json", question_options: question.question_options)
  end

  def show_question_option(conn, %{"id" => id}) do
    qo = Polls.get_question_option!(id)
    render(conn, "question_option.json", question_option: qo)
  end

  def get_question_option(conn, %{
        "id_question" => id_question,
        "question_option_index" => question_option_index
      }) do
    question_option = Polls.get_question_option(id_question, question_option_index)
    render(conn, "question_option.json", question_option: question_option)
  end

  def create_question_options(conn, %{"id" => id, "question_option" => question_option_params}) do
    with {:ok, %QuestionOption{} = question_options} <-
           Polls.create_question_option!(id, question_option_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        Routes.question_path(conn, :show_question_option, question_options.id)
      )
      |> render("question_options.json", question_options: [question_options])
    end
  end

  def vote(conn, %{
        "id_question" => id_question,
        "question_option_index" => question_option_index
      }) do
    with {:ok, %Vote{} = vote} <- Polls.create_vote(id_question, question_option_index) do
      conn
      |> put_status(:created)
      |> render("vote.json", vote: vote)
    end
  end
end
