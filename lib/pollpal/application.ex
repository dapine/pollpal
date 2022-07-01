defmodule Pollpal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Pollpal.Repo,
      # Start the Telemetry supervisor
      PollpalWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pollpal.PubSub},
      # Start the Endpoint (http/https)
      PollpalWeb.Endpoint
      # Start a worker by calling: Pollpal.Worker.start_link(arg)
      # {Pollpal.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pollpal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PollpalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
