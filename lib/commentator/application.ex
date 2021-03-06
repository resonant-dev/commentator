defmodule Commentator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Commentator.PromEx,
      Commentator.Repo,
      CommentatorWeb.Telemetry,
      {Phoenix.PubSub, name: Commentator.PubSub},
      CommentatorWeb.SitePresence,
      CommentatorWeb.Endpoint

      # Start a worker by calling: Commentator.Worker.start_link(arg)
      # {Commentator.Worker, arg}
    ]

    # Attach Telemetry handler for Ecto events
    :ok =
      :telemetry.attach(
        "logger-json-ecto",
        [:commentator, :repo, :query],
        &LoggerJSON.Ecto.telemetry_logging_handler/4,
        :info
      )

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Commentator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CommentatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
