defmodule Day05 do
  @moduledoc false
  import Common

  def part1(args) do
    args
    |> parse_input(%{ranges: [], ids: []})
    |> find_fresh()
  end

  def part2(args) do
    args
    |> parse_input(%{ranges: [], ids: []})
    |> condense_ranges()
    |> Enum.sum_by(&Range.size/1)
  end

  defp parse_input([], inventory), do: Map.new(inventory, fn {k, v} -> {k, Enum.reverse(v)} end)

  defp parse_input([line | args], inventory) do
    case String.split(line, "-") do
      [start, stop] ->
        range = String.to_integer(start)..String.to_integer(stop)

        parse_input(args, %{inventory | ranges: [range | inventory.ranges]})

      [id] ->
        parse_input(args, %{inventory | ids: [String.to_integer(id) | inventory.ids]})
    end
  end

  defp find_fresh(%{ranges: ranges, ids: ids}) do
    Enum.reduce(ids, 0, fn id, fresh ->
      if Enum.any?(ranges, fn range -> id in range end) do
        fresh + 1
      else
        fresh
      end
    end)
  end

  defp condense_ranges(%{ranges: ranges}) when is_list(ranges) do
    condense_ranges(ranges)
  end

  defp condense_ranges(ranges) when is_list(ranges) do
    range_len = length(ranges)

    simulate({ranges, []}, fn
      _i, {[], coverages} ->
        if length(coverages) == range_len do
          return(coverages)
        else
          # Call again until nothing has changed
          coverages |> condense_ranges() |> return()
        end

      _i, {[r | remaining_ranges], coverages} ->
        {:ok, merged_range, overlaps} = merge_overlaps(r, coverages, [])

        if r == merged_range do
          continue({remaining_ranges, [merged_range | overlaps]})
        else
          continue({[merged_range | remaining_ranges], overlaps})
        end
    end)
  end

  defp merge_overlaps(range, [], non_overlapped), do: {:ok, range, non_overlapped}

  defp merge_overlaps(range, [check_range | remaining], non_overlapped) do
    if Range.disjoint?(range, check_range) do
      merge_overlaps(range, remaining, [check_range | non_overlapped])
    else
      range
      |> merge_ranges(check_range)
      |> merge_overlaps(remaining, non_overlapped)
    end
  end

  defp merge_ranges(r1, r2) do
    min(r1.first, r2.first)..max(r1.last, r2.last)
  end
end
