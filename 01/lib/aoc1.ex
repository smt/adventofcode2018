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
    case Integer.parse str do
      {int, _} -> int
      :error   -> 0
    end
  end

  @doc """
  Reduce frequency variations list to single accumulated value.

  ## Examples

      iex> Aoc1.find_first_repeat 3, {[3, 1], false}
      {:cont, {[6, 3, 1], false}}

      iex> Aoc1.find_first_repeat -2, {[3, 1], false}
      {:halt, {[1, 3, 1], true}}

  """
  def find_first_repeat(x, state) do
    {acc, _} = state
    [ov | _] = acc
    nv = x + ov
    if Enum.member? acc, nv do
      {:halt, {[nv | acc], true}}
    else
      {:cont, {[nv | acc], false}}
    end
  end

  @doc """
  Reduce frequency variations list to single accumulated value.

  ## Examples

      iex> Aoc1.process_data [1, 1, -2]
      0

      iex> Aoc1.process_data [1, -1]
      0

      iex> Aoc1.process_data [3, 3, 4, -2, -4]
      10

      iex> Aoc1.process_data [-6, 3, 8, 5, -6]
      5

      iex> Aoc1.process_data [7, 7, -2, -7, -4]
      14

  """
  def process_data(data, state \\ {[0], false}) do
    {acc, is_finished} = Enum.reduce_while(data, state, &find_first_repeat/2)
    case is_finished do
      true -> List.first acc
      _    -> process_data(data, {acc, is_finished})
    end
  end

  @doc """
  Compute the resulting frequency from an input file of variations.
  """
  def main(filepath) do
    filepath
    |> File.open!([:read])
    |> IO.read(:all)
    |> String.split(~r/\n/)
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(&parse_int/1)
    |> process_data
  end
  def main do
    IO.puts "Error: Please provide the path to the data file."
  end

end
