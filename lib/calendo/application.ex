defmodule Calendo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Calendo.Repo,
      # Start the Telemetry supervisor
      CalendoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Calendo.PubSub},
      # Start the Endpoint (http/https)
      CalendoWeb.Endpoint
      # Start a worker by calling: Calendo.Worker.start_link(arg)
      # {Calendo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Calendo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CalendoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
