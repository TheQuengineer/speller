defmodule Speller.Mutator do
  @moduledoc """
  Responsible for the mutaton of the current gene  and the calculation of the
  fitness of that specific mutation. The `Mutator` is responsible for tracking
  the best fitness that it has calculated during the different Epochs it has
  completed. When it finds a guess that has a better fitness than the old it
  replaces that new fitness value with the old.
  """

  @doc """
  Calculates the fitness for a given GeneSet
  """
  def get_fitness(gene_set) when is_list(gene_set) do
    target_list =
      Map.fetch!(Speller.Gene.sequences(), :target)
      |> String.graphemes()

      Enum.zip(gene_set, target_list)
      |> Enum.filter(fn(tuple) -> elem(tuple, 0) == elem(tuple, 1) end)
      |> Enum.count()
  end

  def compare_fitness(new_fitness, best_fitness, gene_set) when best_fitness < new_fitness do
    Speller.Gene.update(%{fitness: new_fitness, gene: gene_set}, :best_guess)
    Speller.Gene.update(new_fitness, :best_fitness)
    Speller.Gene.update(gene_set, :gene_set)
    Speller.Gene.show(Speller.Gene.guess())
  end

  def compare_fitness(new_fitness, best_fitness, gene_set) when best_fitness >= new_fitness do
    Speller.Gene.update(%{fitness: best_fitness, gene: gene_set}, :best_guess)
  end

  @doc """
  Mutates the genes given with random values from the given list of genes. This
  is a public function called by the `Gene` module.
  """
  def mutate(gene_set) do
    :sfmt.seed :os.timestamp

    gene_pool = Map.fetch!(Speller.Gene.sequences(), :gene_pool)

    index = 0..length(gene_set) |> Enum.random()
    random_genes = Enum.take_random(gene_pool, 2)

    set_new(gene_set, Enum.at(gene_set, index), index, random_genes)
  end

  defp set_new(gene_set, chosen_gene, index, [gene1, gene2]) when chosen_gene == gene1 do
    List.replace_at(gene_set, index , gene2) |> Speller.Gene.update(:gene_set)
  end

  defp set_new(gene_set, _, index, alternates) do
    List.replace_at(gene_set, index, hd(alternates)) |> Speller.Gene.update(:gene_set)
  end
end
