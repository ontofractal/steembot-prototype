defmodule SteembotPrototype.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  alias SteembotPrototype.NewPostsConsumer
  import Supervisor.Spec
  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: SteembotPrototype.Worker.start_link(arg)
      # {SteembotPrototype.Worker, arg},
      worker(NewPostsConsumer, [[subscribe_to: [Steemex.Stage.MungedOps]]])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SteembotPrototype.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
