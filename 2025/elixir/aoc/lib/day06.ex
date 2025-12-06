defmodule Day06 do
  @moduledoc false
  import Common

  def part1(args) do
    args
    |> build_lists([])
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.sum_by(&perform_operation/1)
  end

  def part2(_args) do
  end

  defp build_lists([ops_line], results) do
    [String.split(ops_line, " ", trim: true) | Enum.reverse(results)]
  end

  defp build_lists([number_line | rest], results) do
    build_lists(rest, [read_ints(number_line) | results])
  end

  defp read_ints(line) do
    ~r/-?\d+/
    |> Regex.scan(line)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end

  defp perform_operation([op | numbers]) do
    case op do
      "*" ->
        Enum.reduce(numbers, 1, fn x, acc -> x * acc end)

      "+" ->
        Enum.reduce(numbers, 0, fn x, acc -> x + acc end)
    end
  end
end
