defmodule Pollpal.PollsTest do
  use Pollpal.DataCase

  alias Pollpal.Polls

  describe "questions" do
    alias Pollpal.Polls.Question

    import Pollpal.PollsFixtures

    @invalid_attrs %{description: nil, ip_duplication_check: nil, mode: nil, title: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Polls.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Polls.get_question!(question.id) == question
    end

    test "get_question_with_options/1 returns the question and associated question options with given id" do
      question = question_fixture_with_options()
      assert Polls.get_question_with_options(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{
        description: "some description",
        ip_duplication_check: true,
        mode: :multiple,
        title: "some title"
      }

      assert {:ok, %Question{} = question} = Polls.create_question(valid_attrs)
      assert question.description == "some description"
      assert question.ip_duplication_check == true
      assert question.mode == :multiple
      assert question.title == "some title"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()

      update_attrs = %{
        description: "some updated description",
        ip_duplication_check: false,
        mode: :exclusive,
        title: "some updated title"
      }

      assert {:ok, %Question{} = question} = Polls.update_question(question, update_attrs)
      assert question.description == "some updated description"
      assert question.ip_duplication_check == false
      assert question.mode == :exclusive
      assert question.title == "some updated title"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_question(question, @invalid_attrs)
      assert question == Polls.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Polls.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Polls.change_question(question)
    end
  end
end
