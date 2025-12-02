defmodule Day02Test do
  use ExUnit.Case

  import Elixir.Day02
  import Test.Common

  @example_input "test/input/day02/example"
  @real_input "test/input/day02/real"

  defp read_input(file) do
    file
    |> read_lines()
    |> hd()
    |> String.split(",", trim: true)
  end

  test "part1 example" do
    input = read_input(@example_input)
    result = part1(input)

    assert 1_227_775_554 == result
  end

  test "part1 real" do
    input = read_input(@real_input)
    result = part1(input)

    assert 29_818_212_493 == result
  end

  @tag :skip
  test "part2 example" do
    input = read_input(@example_input)
    result = part2(input)

    assert 0 == result
  end

  @tag :skip
  test "part2 real" do
    input = read_input(@real_input)
    result = part2(input)

    assert 0 == result
  end
end
