defmodule API.Application do
  use Application
  require Logger

  def start(_type, _args) do
    Logger.info("Starting server at http://localhost:8080/")
    Supervisor.start_link(children(), opts())
  end

  defp children do
    [
      {Plug.Cowboy, scheme: :http, plug: API.Endpoint, options: [port: 8080]}
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: WTTJ.Supervisor
    ]
  end
end
