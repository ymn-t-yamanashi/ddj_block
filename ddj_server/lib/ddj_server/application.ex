defmodule DdjServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DdjServerWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:ddj_server, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DdjServer.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DdjServer.Finch},
      # Start a worker by calling: DdjServer.Worker.start_link(arg)
      # {DdjServer.Worker, arg},
      # Start to serve requests, typically the last entry
      DdjServerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DdjServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DdjServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
