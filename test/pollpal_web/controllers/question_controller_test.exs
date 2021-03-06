defmodule PollpalWeb.QuestionControllerTest do
  use PollpalWeb.ConnCase

  import Pollpal.PollsFixtures

  alias Pollpal.Polls.Question

  @create_attrs %{
    description: "some description",
    ip_duplication_check: true,
    mode: :multiple,
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    ip_duplication_check: false,
    mode: :exclusive,
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, ip_duplication_check: nil, mode: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all questions", %{conn: conn} do
      conn = get(conn, Routes.question_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create question" do
    test "renders question when data is valid", %{conn: conn} do
      conn = post(conn, Routes.question_path(conn, :create), question: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.question_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "ip_duplication_check" => true,
               "mode" => "multiple",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.question_path(conn, :create), question: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update question" do
    setup [:create_question]

    test "renders question when data is valid", %{
      conn: conn,
      question: %Question{id: id} = question
    } do
      conn = put(conn, Routes.question_path(conn, :update, question), question: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.question_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "ip_duplication_check" => false,
               "mode" => "exclusive",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, question: question} do
      conn = put(conn, Routes.question_path(conn, :update, question), question: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "get question options" do
    test "renders question options when exists", %{conn: conn} do
      %Pollpal.Polls.Question{:question_options => _question_options, :id => id} =
        question_fixture_with_options()

      conn = get(conn, Routes.question_path(conn, :get_question_options, id))
      assert _question_options = json_response(conn, 200)["data"]
    end
  end

  describe "delete question" do
    setup [:create_question]

    test "deletes chosen question", %{conn: conn, question: question} do
      conn = delete(conn, Routes.question_path(conn, :delete, question))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, Routes.question_path(conn, :show, question))
      end)
    end
  end

  defp create_question(_) do
    question = question_fixture()
    %{question: question}
  end
end
