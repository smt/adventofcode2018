defmodule Aoc1 do
  @moduledoc """
  Advent of Code 2018, Day 1
  """

  @doc """
  Parse an integer from a string, defaulting to 0

  ## Examples

      iex> Aoc1.parse_int "-5"
      -5

      iex> Aoc1.parse_int "+8"
      8

      iex> Aoc1.parse_int "15"
      15

      iex> Aoc1.parse_int "3.14159"
      3

  Unparsable values will be calculated as zeroes:

      iex> Aoc1.parse_int ""
      0

      iex> Aoc1.parse_int "not a number"
      0
  """
  def parse_int(str) do
    case Integer.parse(str) do
      {int, _} -> int
      :error   -> 0
    end
  end

  def find_first_repeat(x, acc) do
    {found, sum} = acc
    new_sum = x + sum
    if Enum.member?(found, new_sum) do
      IO.puts "wat"
      {:halt, {found, new_sum}}
    else
      {:cont, {[new_sum | found], x + sum}}
    end
  end

  @doc """
  Reduce frequency variations list to single accumulated value.

  ## Examples

      iex> Aoc1.process_data ["+1", "+2", "+3", "+4"]
      10

      iex> Aoc1.process_data ["-1", "-2", "-3"]
      {[-6, -3, -1], -6}

      iex> Aoc1.process_data ["-10", "wat", "+13"]
      {[10, 6, 3, 1], 10}

      iex> Aoc1.process_data ["+8", "+7", "-7", "+7", "+1"]
      {[15, 8], 15}
  """
  def process_data(data) do
    data
    |> Enum.map(&parse_int/1)
    |> Enum.reduce_while({[], 0}, &find_first_repeat/2)
  end

  @doc """
  Compute the resulting frequency from an input file of variations.
  """
  def main(filepath) do
    filepath
    |> File.open!([:read])
    |> IO.read(:all)
    |> String.split(~r/\n/)
    |> process_data
  end
  def main do
    IO.puts "Error: Please provide the path to the data file."
  end

end
