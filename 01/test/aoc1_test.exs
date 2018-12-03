defmodule Aoc1Test do
  use ExUnit.Case
  doctest Aoc1

  test "Calculate correct value from fixture data" do
    assert Aoc1.main("test/aoc1_fixture.txt") == 3
  end
end
