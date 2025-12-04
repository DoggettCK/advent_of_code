defmodule Day03 do
  @moduledoc false
  import Common

  def part1(args) do
    Enum.sum_by(args, &find_max_joltage(&1, 2))
  end

  def part2(args) do
    Enum.sum_by(args, &find_max_joltage(&1, 12))
  end

  defp find_max_joltage(bank, n) do
    digits =
      bank
      |> String.to_integer()
      |> Integer.digits()
      |> list_to_arraymap()

    {joltage, _} =
      Enum.reduce(n..1//-1, {0, -1}, fn pos, {battery, prev_index} ->
        best_index =
          Enum.reduce((prev_index + 1)..(map_size(digits) - pos), prev_index + 1, fn i, best ->
            if digits[best] < digits[i] do
              i
            else
              best
            end
          end)

        {battery * 10 + digits[best_index], best_index}
      end)

    joltage
  end
end
