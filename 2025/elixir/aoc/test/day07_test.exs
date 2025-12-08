defmodule Day07Test do
  use ExUnit.Case

  import Elixir.Day07
  import Test.Common

  @example_input "test/input/day07/example"
  @real_input "test/input/day07/real"

  test "part1 example" do
    input = read_grid(@example_input)
    result = part1(input)

    assert 21 == result
  end

  test "part1 real" do
    input = read_grid(@real_input)
    result = part1(input)

    assert 1649 == result
  end

  @tag :skip
  test "part2 example" do
    input = read_grid(@example_input)
    result = part2(input)

    assert 0 == result
  end

  @tag :skip
  test "part2 real" do
    input = read_grid(@real_input)
    result = part2(input)

    assert 0 == result
  end
end
