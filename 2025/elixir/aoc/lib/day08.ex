defmodule Day08 do
  @moduledoc false
  import Common

  def part1(args, iterations) do
    {_points, graph, shortest_distances} = build_data(args)

    shortest_distances
    |> Enum.take(iterations)
    |> Enum.reduce(graph, fn {_distance, {a, b}}, g ->
      Graph.add_edge(g, a, b)
    end)
    |> Graph.components()
    |> Enum.group_by(&length/1)
    |> Map.keys()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def part2(args) do
    {points, graph, shortest_distances} = build_data(args)

    Enum.reduce_while(shortest_distances, {graph, 0}, fn {_dist, {i, j}}, {g, last_conn_xx} ->
      case g |> Graph.components() |> length() do
        1 ->
          return(last_conn_xx)

        _ ->
          case Graph.get_paths(g, i, j) do
            [] ->
              [x1 | _] = Map.get(points, i)
              [x2 | _] = Map.get(points, j)
              continue({Graph.add_edge(g, i, j), x1 * x2})

            _ ->
              continue({g, last_conn_xx})
          end
      end
    end)
  end

  defp build_data(coords) do
    points =
      coords
      |> Stream.with_index(1)
      |> Map.new(fn {k, v} -> {v, k} end)

    n = map_size(points)

    graph = Enum.reduce(1..n, Graph.new(), fn v, g -> Graph.add_vertex(g, v) end)

    shortest_distances =
      for i <- 1..(n - 1), j <- (i + 1)..n do
        {dist(Map.get(points, i), Map.get(points, j)), {i, j}}
      end

    {points, graph, Enum.sort(shortest_distances)}
  end

  defp dist([x1, y1, z1], [x2, y2, z2]) do
    (x1 - x2) ** 2 + (y1 - y2) ** 2 + (z1 - z2) ** 2
  end
end
