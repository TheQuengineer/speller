defmodule Speller.Engine do
  @moduledoc """
  The very heart of the algorithm which is essentially a recurresive loop.
  It Works toward the genes target which is defined by the user at startup.
  """
  alias Speller.Mutator
  alias Speller.Gene

  def generate_guess() do
    Mutator.mutate(Gene.gene_set())

    Mutator.get_fitness(Gene.gene_set())
    |> Mutator.compare_fitness(Gene.best_fitness(), Speller.Gene.gene_set())

    generate_guess(Speller.Gene.guess())
  end

  def generate_guess(%{fitness: 0, gene: _}) do
    generate_guess()
  end

  def generate_guess(guess) do
     best_guess = Enum.join(guess.gene)
     target = Map.fetch!(Speller.Gene.sequences(), :target)

     target_reached?(target, best_guess)
     |> complete(guess)
  end

  def target_reached?(target, guess), do: String.equivalent?(guess, target)

  def complete(false, _) do
    Gene.generate_gene_set()
    generate_guess()
  end

  def complete(true, guess) do
    IO.puts("TARGET REACHED!!!!")
    Gene.show(guess)
    Gene.reset()
  end
end
