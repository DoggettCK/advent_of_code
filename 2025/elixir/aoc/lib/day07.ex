defmodule Day07 do
  @moduledoc false
  import Common

  def part1(args) do
    {start_x, _} = find_single(args.grid, "S")
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

  def part2(args) do
    {start_x, _} = find_single(args.grid, "S")
    max_y = args.max_y

    splitters =
      args.grid
      |> filter_from_grid(["^"])
      |> Enum.group_by(fn {{_, y}, _} -> y end, fn {{x, _}, _} -> x end)

    initial_counts =
      0..(args.max_x - 1)
      |> Map.new(&{&1, 0})
      |> Map.put(start_x, 1)

    simulate({1, initial_counts}, fn
      ^max_y, {count, _} ->
        return(count)

      0, {count, counts} ->
        continue({count, counts})

      i, {count, counts} ->
        case Map.get(splitters, i) do
          nil ->
            continue({count, counts})

          row_splitters ->
            row_splitters
            |> Enum.reduce({count, counts}, fn col, {inner_count, inner_counts} ->
              current_column_count = Map.get(inner_counts, col)

              if current_column_count == 0 do
                {inner_count, inner_counts}
              else
                new_counts =
                  inner_counts
                  |> Map.update(col - 1, current_column_count, &(&1 + current_column_count))
                  |> Map.update(col + 1, current_column_count, &(&1 + current_column_count))
                  |> Map.put(col, 0)

                {inner_count + current_column_count, new_counts}
              end
            end)
            |> continue()
        end
    end)
  end
end
