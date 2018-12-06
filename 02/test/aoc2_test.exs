defmodule Aoc2Test do
  use ExUnit.Case
  doctest Aoc2

  test "Calculate correct value from fixture data" do
    assert Aoc2.main("test/aoc2_fixture.txt") == 12
  end
end
