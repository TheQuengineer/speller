defmodule Speller do
  use Application

  alias Speller.Gene
  alias Speller.Engine

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Gene, [], [function: :start])
    ]

    opts = [strategy: :one_for_one, name: Speller.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def spell(user_target) do
    IO.puts("WORKING TOWARD GOAL: #{user_target}")
    Gene.show_header()
    Gene.set_target(user_target)
    Engine.generate_guess()
  end
end
