defmodule Day05 do
  @moduledoc false
  import Common

  def part1(args) do
    args
    |> parse_input(%{ranges: [], ids: []})
    |> find_fresh()
  end

  def part2(_args) do
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
end
