defmodule Day02 do
  @moduledoc false
  import Common

  def part1(args) do
    Enum.reduce(args, 0, &find_invalid_ids/2)
  end

  def part2(args) do
    Enum.reduce(args, 0, &find_invalid_ids_v2/2)
  end

  defp find_invalid_ids(range_str, sum) do
    case build_ranges(range_str) do
      {:ok, {actual_range, prefix_range}} ->
        prefix_range
        |> Enum.map(fn prefix ->
          double = double_prefix(prefix)

          if double in actual_range do
            double
          else
            0
          end
        end)
        |> Enum.sum()
        |> Kernel.+(sum)

      _ ->
        sum
    end
  end

  defp build_ranges(range_str) do
    [rs, re] = String.split(range_str, "-")

    actual_range = String.to_integer(rs)..String.to_integer(re)
    start_len = String.length(rs)
    end_len = String.length(re)

    case {is_odd?(start_len), is_odd?(end_len)} do
      {true, true} ->
        if start_len == end_len do
          # Odd length strings can't be two equal-length strings repeated,
          # therefore, if they're both the same odd length, it's impossible to
          # have a match in the range.
          error({actual_range, 0..0})
        else
          # TODO: Figure out what to do if it spans two odd ranges (i.e. 355-10723)
          # NOTE: Don't worry about it for now, doesn't appear in the data
          error({actual_range, 0..0})
        end

      {false, true} ->
        ok({actual_range, get_even_half(rs, start_len)..last_even_half_before(end_len)})

      {true, false} ->
        ok({actual_range, next_even_half_after(start_len)..get_even_half(re, end_len)})

      {false, false} ->
        ok({actual_range, get_even_half(rs, start_len)..get_even_half(re, end_len)})
    end
  end

  defp get_even_half(str, len) do
    half_len = div(len, 2)

    str
    |> String.slice(0..(half_len - 1))
    |> String.to_integer()
  end

  defp last_even_half_before(3), do: 9
  defp last_even_half_before(5), do: 99
  defp last_even_half_before(7), do: 999
  defp last_even_half_before(9), do: 9999
  defp last_even_half_before(11), do: 99_999

  defp next_even_half_after(1), do: 1
  defp next_even_half_after(3), do: 10
  defp next_even_half_after(5), do: 100
  defp next_even_half_after(7), do: 1000
  defp next_even_half_after(9), do: 10_000

  defp double_prefix(n) when n < 10, do: n * 10 + n
  defp double_prefix(n) when n < 100, do: n * 100 + n
  defp double_prefix(n) when n < 1000, do: n * 1000 + n
  defp double_prefix(n) when n < 10_000, do: n * 10_000 + n
  defp double_prefix(n) when n < 100_000, do: n * 100_000 + n
  defp double_prefix(n) when n < 1_000_000, do: n * 1_000_000 + n
  defp double_prefix(n) when n < 10_000_000, do: n * 10_000_000 + n

  # Part 2
  defp find_invalid_ids_v2(range_str, sum) do
    [rs, re] = String.split(range_str, "-")

    actual_range = String.to_integer(rs)..String.to_integer(re)
    start_len = String.length(rs)
    end_len = String.length(re)

    (possibilities(start_len) ++ possibilities(end_len))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.filter(fn x -> x in actual_range end)
    |> Enum.sum()
    |> Kernel.+(sum)
  end

  defp possibilities(1), do: []

  defp possibilities(2) do
    [possibilities_of_length(1, 2)]
  end

  defp possibilities(3) do
    [possibilities_of_length(1, 3)]
  end

  defp possibilities(4) do
    [possibilities_of_length(1, 4), possibilities_of_length(2, 2)]
  end

  defp possibilities(5) do
    [possibilities_of_length(1, 5)]
  end

  defp possibilities(6) do
    [
      possibilities_of_length(1, 6),
      possibilities_of_length(2, 3),
      possibilities_of_length(3, 2)
    ]
  end

  defp possibilities(7) do
    [possibilities_of_length(1, 7)]
  end

  defp possibilities(8) do
    [
      possibilities_of_length(1, 8),
      possibilities_of_length(2, 4),
      possibilities_of_length(4, 2)
    ]
  end

  defp possibilities(9) do
    [
      possibilities_of_length(1, 9),
      possibilities_of_length(3, 3)
    ]
  end

  defp possibilities(10) do
    [
      possibilities_of_length(1, 10),
      possibilities_of_length(2, 5),
      possibilities_of_length(5, 2)
    ]
  end

  defp possibilities_of_length(1, n) do
    for i <- 1..9 do
      [i] |> List.duplicate(n) |> List.flatten() |> Integer.undigits(10)
    end
  end

  defp possibilities_of_length(2, n) do
    for i <- 10..99 do
      [i] |> List.duplicate(n) |> List.flatten() |> Integer.undigits(100)
    end
  end

  defp possibilities_of_length(3, n) do
    for i <- 100..999 do
      [i] |> List.duplicate(n) |> List.flatten() |> Integer.undigits(1_000)
    end
  end

  defp possibilities_of_length(4, n) do
    for i <- 1000..9999 do
      [i] |> List.duplicate(n) |> List.flatten() |> Integer.undigits(10_000)
    end
  end

  defp possibilities_of_length(5, n) do
    for i <- 10_000..99_999 do
      [i] |> List.duplicate(n) |> List.flatten() |> Integer.undigits(100_000)
    end
  end
end
