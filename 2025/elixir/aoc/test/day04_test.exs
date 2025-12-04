defmodule Day04Test do
  use ExUnit.Case

  import Elixir.Day04
  import Test.Common

  @example_input "test/input/day04/example"
  @real_input "test/input/day04/real"

  test "part1 example" do
    input = read_grid(@example_input)
    result = part1(input)

    assert 13 == result
  end

  test "part1 real" do
    input = read_grid(@real_input)
    result = part1(input)

    assert 1467 == result
  end

  test "part2 example" do
    input = read_grid(@example_input)
    result = part2(input)

    assert 43 == result
  end

  test "part2 real" do
    input = read_grid(@real_input)
    result = part2(input)

    assert 8484 == result
  end
end
