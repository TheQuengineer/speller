defmodule Speller.Mixfile do
  use Mix.Project

  def project do
    [app: :speller,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :sfmt],
     mod: {Speller, []}]
  end

  defp deps do
    [
      {:sfmt, git: "https://github.com/jj1bdx/sfmt-erlang.git"}
    ]
  end
end
