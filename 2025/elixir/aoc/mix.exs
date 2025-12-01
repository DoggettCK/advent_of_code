defmodule Aoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc,
      version: "0.1.0",
      elixir: "~> 1.19",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cachex, "~> 4.1.1"},
      {:combinatorics, "~> 0.1.0"},
      {:igniter, "~> 0.7.0"},
      {:libgraph, "~> 0.16.0"},
      {:math, "~> 0.7.0"},
      {:mix_test_watch, "~> 1.4.0", only: [:dev, :test], runtime: false},
      {:styler, "~> 1.9", only: [:dev, :test], runtime: false},
      {:statistics, "~> 0.6.3"}
    ]
  end
end
