defmodule Day03Test do
  use ExUnit.Case

  import Elixir.Day03
  import Test.Common

  @example_input "test/input/day03/example"
  @real_input "test/input/day03/real"

  test "part1 example" do
    input = read_lines(@example_input)
    result = part1(input)

    assert 357 == result
  end

  test "part1 real" do
    input = read_lines(@real_input)
    result = part1(input)

    assert 16_927 == result
  end

  test "part2 example" do
    input = read_lines(@example_input)
    result = part2(input)

    assert 3_121_910_778_619 == result
  end

  test "part2 real" do
    input = read_lines(@real_input)
    result = part2(input)

    assert 167_384_358_365_132 == result
  end
end
