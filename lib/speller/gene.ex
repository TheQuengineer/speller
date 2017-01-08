defmodule Speller.Gene do
  @moduledoc """
  The gene is responsible for making up the full problem space to
  be explored. It will be responsible for fetching the `genset`. In this case
  the `geneset` is simply the letters & punctuations of the alphabet that the speller
  needs in order to spell the word or phrase that is being requested.

  It builds the initial mutator that will be utilized by the algorithm to define
  itself as the target. The target is supplied by the user. The mutator will
  automatically be built once the Gene is started by the Speller's top level
  supervisor.
  """

  @letters_file "lib/speller/letters.txt"

  defstruct [
    best_guess: %{gene: [], fitness: 0},
    gene_pool: nil,
    target: nil,
    gene_set: nil,
    best_fitness: 0
  ]


  ################
  #      API     #
  ################

  def start do
     Agent.start(fn() ->
       %Speller.Gene{
         gene_pool: gene_pool()
       }
     end, [name: __MODULE__])
  end

  def sequences do
    Agent.get(__MODULE__, &(&1))
  end

  def gene_set do
    Map.fetch!(Speller.Gene.sequences(), :gene_set)
  end

  def guess do
    Map.fetch!(Speller.Gene.sequences(), :best_guess)
  end

  def mutate(gene_set) when is_list(gene_set) do
    Speller.Mutator.mutate(gene_set)
  end

  def best_fitness do
    Map.fetch!(sequences(), :best_fitness)
  end

  @doc """
  Updates a Gene's attribute and returns the updated data structure.
  """
  @spec update(String.t(), Atom.t()) :: Map.t()
  def update(item, key) do
    Agent.get_and_update(__MODULE__, fn(map) ->
      {map, Map.put(map, key, item)}
    end)
  end

  def set_target(target) do
    update(target, :target)
    generate_gene_set()
  end

  def show_header() do
    IO.puts("""
    ====================================
    RESULT                       FITNESS
    """)
  end

  def show(best_guess) do
    result = Enum.join(best_guess.gene)
    IO.puts("#{result}                             #{Integer.to_string(best_guess.fitness)}")
  end

  def reset do
    update(0, :best_fitness)
  end

  def generate_gene_set() do
    sequences()
    |> Map.fetch!(:target)
    |> String.graphemes
    |> Enum.count()
    |> build_gene_set_with()
  end

  ###################
  #  IMPLEMENTATION #
  ###################

  defp gene_pool() do
    File.read!(@letters_file)
    |> String.split("\n")
    |> List.replace_at(-1, " ")
  end

  defp build_gene_set_with(size) do
    Enum.take_random(gene_pool(), size)
    |> update(:gene_set)
  end
end
