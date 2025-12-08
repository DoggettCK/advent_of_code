defmodule Day07 do
  @moduledoc false
  import Common

  def part1(args) do
    {start_x, min_y} = find_single(args.grid, "S")
    max_y = args.max_y

    splitters =
      args.grid
      |> filter_from_grid(["^"])
      |> Enum.group_by(fn {{_, y}, _} -> y end, fn {{x, _}, _} -> x end)
      |> Map.put(0, [start_x])

    simulate({0, [start_x]}, fn
      ^max_y, {count, _beams} ->
        return(count)

      i, {count, beams} ->
        case Map.get(splitters, i) do
          nil ->
            continue({count, beams})

          row_splitters ->
            row_xs = MapSet.new(row_splitters)
            beam_xs = MapSet.new(beams)

            beam_hits = MapSet.intersection(beam_xs, row_xs)

            beam_splits =
              beam_hits
              |> Enum.flat_map(&[&1 - 1, &1 + 1])
              |> MapSet.new()

            beam_misses = MapSet.difference(beam_xs, row_xs)

            new_beams = beam_splits |> MapSet.union(beam_misses) |> MapSet.to_list()

            continue({count + MapSet.size(beam_hits), new_beams})
        end
    end)
  end

  def part2(_args) do
  end
end
