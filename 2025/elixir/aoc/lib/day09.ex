defmodule Day09 do
  @moduledoc false
  import Common

  def part1(args) do
    args |> build_data() |> elem(1) |> hd() |> elem(0)
  end

  def part2(_args) do
  end

  defp build_data(coords) do
    points =
      coords
      |> Stream.with_index(1)
      |> Map.new(fn {k, v} -> {v, k} end)

    n = map_size(points)

    areas =
      for i <- 1..(n - 1), j <- (i + 1)..n do
        {area(Map.get(points, i), Map.get(points, j)), {i, j}}
      end

    {points, Enum.sort(areas, :desc)}
  end

  defp area([x1, y1], [x2, y2]) do
    (abs(x1 - x2) + 1) * (abs(y1 - y2) + 1)
  end
end
