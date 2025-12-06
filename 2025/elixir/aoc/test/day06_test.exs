defmodule Day06Test do
  use ExUnit.Case

  import Elixir.Day06
  import Test.Common

  @example_input "test/input/day06/example"
  @real_input "test/input/day06/real"

  test "part1 example" do
    input = read_lines(@example_input)
    result = part1(input)

    assert 4_277_556 == result
  end

  test "part1 real" do
    input = read_lines(@real_input)
    result = part1(input)

    assert 6_172_481_852_142 == result
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
