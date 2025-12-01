defmodule Day01 do
  @moduledoc false

  def part1(args) do
    args
    |> turns_to_numbers()
    |> count_zeroes(&count_exact_zeroes/2)
  end

  def part2(args) do
    args
    |> turns_to_numbers()
    |> count_zeroes(&count_passed_zeroes/2)
  end

  defp turns_to_numbers(lines) do
    Enum.map(lines, &turn_to_int/1)
  end

  defp count_zeroes(numbers, reduce_func) do
    numbers
    |> Enum.reduce({50, 0}, reduce_func)
    |> elem(1)
  end

  defp turn_to_int("L" <> digit), do: -String.to_integer(digit)
  defp turn_to_int("R" <> digit), do: String.to_integer(digit)

  defp count_exact_zeroes(turn, {current, zeroes}) do
    next_digit = rem(100 + current + turn, 100)

    case next_digit do
      0 ->
        {next_digit, zeroes + 1}

      _ ->
        {next_digit, zeroes}
    end
  end

  defp count_passed_zeroes(turn, {0, zeroes}) do
    next_digit = next_digit(0, turn)
    passes = abs(div(turn, 100))

    {next_digit, zeroes + passes}
  end

  defp count_passed_zeroes(turn, {current, zeroes}) do
    next_digit = next_digit(current, turn)
    passes = calculate_passes(current, turn)

    {next_digit, zeroes + passes}
  end

  defp next_digit(current, turn) do
    rem(rem(turn + current, 100) + 100, 100)
  end

  defp calculate_passes(current, turn) when current + turn < 0 do
    current
    |> Kernel.+(turn)
    |> div(100)
    |> abs()
    |> Kernel.+(1)
  end

  defp calculate_passes(current, turn) when current + turn > 100 do
    current
    |> Kernel.+(turn)
    |> div(100)
  end

  defp calculate_passes(current, turn) do
    case current + turn do
      0 -> 1
      100 -> 1
      _ -> 0
    end
  end
end
