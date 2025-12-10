defmodule Day08 do
  @moduledoc false
  import Common

  def part1(args, iterations \\ 10) do
    points =
      args
      |> Stream.with_index(1)
      |> Map.new(fn {k, v} -> {v, k} end)

    n = map_size(points)

    graph =
      points
      |> Map.keys()
      |> Enum.reduce(Graph.new(), fn v, g -> Graph.add_vertex(g, v) end)

    shortest_distances =
      for i <- 1..(n - 1), j <- (i + 1)..n do
        {dist(Map.get(points, i), Map.get(points, j)), {i, j}}
      end

    graph =
      shortest_distances
      |> Enum.sort()
      |> Enum.take(iterations)
      |> Enum.reduce(graph, fn {_distance, {a, b}}, g ->
        Graph.add_edge(g, a, b)
      end)

    graph
    |> Graph.components()
    |> Enum.group_by(&length/1)
    |> Map.keys()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def part2(_args) do
  end

  defp dist([x1, y1, z1], [x2, y2, z2]) do
    (x1 - x2) ** 2 + (y1 - y2) ** 2 + (z1 - z2) ** 2
  end
end
