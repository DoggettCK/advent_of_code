defmodule Day01Test do
  use ExUnit.Case

  import Elixir.Day01
  import Test.Common

  @example_input "test/input/day01/example"
  @real_input "test/input/day01/real"

  @tag :skip
  test "part1 example" do
    input = read_lines(@example_input)
    result = part1(input)

    assert 0 == result
  end

  @tag :skip
  test "part1 real" do
    input = read_lines(@real_input)
    result = part1(input)

    assert 0 == result
  end

  @tag :skip
  test "part2 example" do
    input = read_lines(@example_input)
    result = part2(input)

    assert 0 == result
  end

  @tag :skip
  test "part2 real" do
    input = read_lines(@real_input)
    result = part2(input)

    assert 0 == result
  end
end
