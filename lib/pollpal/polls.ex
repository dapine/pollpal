defmodule Pollpal.Polls do
  @moduledoc """
  The Polls context.
  """

  import Ecto.Query, warn: false
  alias Pollpal.Repo

  alias Pollpal.Polls.Question
  alias Pollpal.Polls.QuestionOption
  alias Pollpal.Polls.Vote

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  def get_question_with_options(id),
    do: Repo.get!(Question, id) |> Repo.preload(:question_options)

  def get_question_option(id_question, question_option_index) do
    query =
      from qo in QuestionOption,
        where: qo.index == ^question_option_index and qo.question_id == ^id_question

    Repo.one(query)
  end

  def create_question_option!(id, attrs \\ %{}) do
    question = get_question!(id)

    %QuestionOption{question: question}
    |> QuestionOption.changeset(attrs)
    |> Repo.insert()
  end

  def get_question_option!(id), do: Repo.get!(QuestionOption, id)

  def create_vote(id_question, question_option_index, attrs \\ %{}) do
    question = get_question!(id_question)
    question_option = get_question_option(question.id, question_option_index)

    %Vote{question_id: question.id, question_option_id: question_option.id}
    |> Vote.changeset(attrs)
    |> Repo.insert()
  end

  def get_vote_from_ip(question_id, remote_ip) do
    query =
      from v in Vote,
        where: v.remote_ip_address == ^remote_ip and v.question_id == ^question_id,
        select: v.id

    Repo.all(query)
  end

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end
end
