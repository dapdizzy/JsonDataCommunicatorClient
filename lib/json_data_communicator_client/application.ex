defmodule JsonDataCommunicatorClient.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {JsonDataCommunicatorClient, "https://db.logsentinel.com/api/"}
      # Starts a worker by calling: JsonDataCommunicatorClient.Worker.start_link(arg)
      # {JsonDataCommunicatorClient.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JsonDataCommunicatorClient.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
