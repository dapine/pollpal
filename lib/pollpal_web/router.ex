defmodule PollpalWeb.Router do
  use PollpalWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PollpalWeb do
    pipe_through :api

    resources "/questions", QuestionController
    get "/questions/:id/options", QuestionController, :get_question_options
    post "/questions/:id/options", QuestionController, :create_question_options

    get "/questions/:id_question/options/:question_option_index",
        QuestionController,
        :get_question_option

    get "/question_options/:id", QuestionController, :show_question_option
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: PollpalWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
