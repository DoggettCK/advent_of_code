defmodule Day08Test do
  use ExUnit.Case

  import Elixir.Day08
  import Test.Common

  @example_input "test/input/day08/example"
  @real_input "test/input/day08/real"

  test "part1 example" do
    input = read_ints(@example_input)
    result = part1(input, 10)

    assert 40 == result
  end

  test "part1 real" do
    input = read_ints(@real_input)
    result = part1(input, 1000)

    assert 122_430 == result
  end

  @tag :skip
  test "part2 example" do
    input = read_ints(@example_input)
    result = part2(input)

    assert 0 == result
  end

  @tag :skip
  test "part2 real" do
    input = read_ints(@real_input)
    result = part2(input)

    assert 0 == result
  end
end
