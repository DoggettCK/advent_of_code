defmodule Day05Test do
  use ExUnit.Case

  import Elixir.Day05
  import Test.Common

  @example_input "test/input/day05/example"
  @real_input "test/input/day05/real"

  test "part1 example" do
    input = read_lines(@example_input)
    result = part1(input)

    assert 3 == result
  end

  test "part1 real" do
    input = read_lines(@real_input)
    result = part1(input)

    assert 607 == result
  end

  test "part2 example" do
    input = read_lines(@example_input)
    result = part2(input)

    assert 14 == result
  end

  test "part2 real" do
    input = read_lines(@real_input)
    result = part2(input)

    assert 342_433_357_244_012 == result
  end
end
