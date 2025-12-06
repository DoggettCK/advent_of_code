defmodule Day06 do
  @moduledoc false

  def part1(args) do
    args
    |> build_lists([])
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.sum_by(&perform_operation/1)
  end

  def part2(args) do
    args
    |> parse_equations()
    |> perform_cephalopod_math()
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

  defp parse_equations(lines) do
    equation_map =
      Enum.reduce(lines, %{}, fn line, acc ->
        line
        |> String.graphemes()
        |> Stream.with_index()
        |> Enum.reduce(acc, fn {c, i}, inner_acc ->
          Map.update(inner_acc, i, c, &(&1 <> c))
        end)
      end)

    Enum.map(0..(map_size(equation_map) - 1), &Map.get(equation_map, &1))
  end

  defp perform_cephalopod_math(lines, operator \\ nil, acc \\ 0, total \\ 0)
  defp perform_cephalopod_math([], _operator, acc, total), do: acc + total

  defp perform_cephalopod_math([line | rest], operator, acc, total) do
    case(line |> String.trim() |> Integer.parse()) do
      :error ->
        # Got blank line indicating new equation, add current to total and start new
        perform_cephalopod_math(rest, nil, 0, acc + total)

      {num, remaining} ->
        case String.trim(remaining) do
          "" ->
            # Just a number
            case operator do
              "*" ->
                perform_cephalopod_math(rest, operator, acc * num, total)

              "+" ->
                perform_cephalopod_math(rest, operator, acc + num, total)
            end

          op ->
            perform_cephalopod_math(rest, op, num, total)
        end
    end
  end
end
