defmodule Day09Test do
  use ExUnit.Case

  import Elixir.Day09
  import Test.Common

  @example_input "test/input/day09/example"
  @real_input "test/input/day09/real"

  test "part1 example" do
    input = read_ints(@example_input)
    result = part1(input)

    assert 50 == result
  end

  test "part1 real" do
    input = read_ints(@real_input)
    result = part1(input)

    assert 4_752_484_112 == result
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
