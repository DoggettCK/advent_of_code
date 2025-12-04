defmodule Day04 do
  @moduledoc false
  import Common

  def part1(args) do
    args
    |> accessible_items()
    |> map_size()
  end

  def part2(args) do
    simulate({args, 0}, &remove_accessible/2)
  end

  defp accessible_items(%{grid: grid}) do
    Map.filter(grid, fn
      {_, "."} ->
        false

      {{x, y}, "@"} ->
        {x, y}
        |> directional_neighbors()
        |> Map.values()
        |> Enum.map(&Map.get(grid, &1))
        |> Enum.frequencies()
        |> Map.get("@", 0)
        |> Kernel.<(4)
    end)
  end

  defp remove_accessible(_iteration, {grid, removed_count}) do
    removable =
      grid
      |> accessible_items()
      |> Map.keys()

    if Enum.empty?(removable) do
      return(removed_count)
    else
      new_grid = %{grid | grid: Map.drop(grid.grid, removable)}
      continue({new_grid, removed_count + length(removable)})
    end
  end
end
