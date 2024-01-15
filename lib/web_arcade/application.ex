defmodule WebArcade.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WebArcadeWeb.Telemetry,
      # Start the Ecto repository
      WebArcade.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: WebArcade.PubSub},
      # Start Finch
      {Finch, name: WebArcade.Finch},
      # Start the Endpoint (http/https)
      WebArcadeWeb.Endpoint
      # Start a worker by calling: WebArcade.Worker.start_link(arg)
      # {WebArcade.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebArcade.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebArcadeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
