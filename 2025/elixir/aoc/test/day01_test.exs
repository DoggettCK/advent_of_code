defmodule Day01Test do
  use ExUnit.Case

  import Day01
  import Test.Common

  @example_input "test/input/day01/example"
  @real_input "test/input/day01/real"

  test "part1 example" do
    input = read_lines(@example_input)
    result = part1(input)

    assert 3 == result
  end

  test "part1 real" do
    input = read_lines(@real_input)
    result = part1(input)

    assert 1129 == result
  end

  test "part2 example" do
    input = read_lines(@example_input)
    result = part2(input)

    assert 6 == result
  end

  test "part2 real" do
    input = read_lines(@real_input)
    result = part2(input)

    assert 6638 == result
  end
end
