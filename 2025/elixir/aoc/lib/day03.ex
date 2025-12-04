defmodule Day03 do
  @moduledoc false
  import Common

  def part1(args) do
    Enum.sum_by(args, &find_max_voltage/1)
  end

  def part3(_args) do
  end

  defp find_max_voltage(bank) do
    bank
    |> String.to_integer()
    |> Integer.digits()
    |> find_max([], 0)
  end

  defp find_max([a, b | remaining], [], _val) do
    # If nothing, just take the first two
    find_max(remaining, [a, b], a * 10 + b)
  end

  defp find_max([a, b | remaining], [x, y], _val) when a > x and a > y do
    # If there are two upcoming numbers, and the first is bigger than either we have, take it
    find_max(remaining, [a, b], a * 10 + b)
  end

  defp find_max([a], [x, y], _val) when a > y do
    # If there is one number remaining, and it's bigger than the ones place, take it
    max(x, y) * 10 + a
  end

  defp find_max([a | remaining], [x, y], _val) when a > x do
    # ex: have 18, find a 4, should be 84
    find_max(remaining, [y, a], y * 10 + a)
  end

  defp find_max([a | remaining], [x, y], _val) when a > y do
    # ex: have 81, find a 4, should be 84
    find_max(remaining, [x, a], x * 10 + a)
  end

  defp find_max([_ | remaining], max, val) do
    find_max(remaining, max, val)
  end

  defp find_max([], _, val), do: val
end
