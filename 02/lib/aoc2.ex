defmodule Aoc2 do
  @moduledoc """
  Documentation for Aoc2.
  """

  @doc """
  Compile the checksum

  ## Examples

      iex> Aoc2.calc_checksums [[2], [2, 3], [3]]
      4

      iex> Aoc2.calc_checksums [[], [2, 3], [3], [3], [2, 3]]
      8

  """
  def calc_checksums(xs) do
    xs
    |> Enum.reduce([0, 0], fn x, [deux, trois] ->
      case x do
        [2, 3] -> [deux + 1, trois + 1]
        [2]    -> [deux + 1, trois]
        [3]    -> [deux, trois + 1]
        _      -> [deux, trois]
      end
    end)
    |> Enum.reduce(1, fn x, acc -> x * acc end)
  end

  @doc """
  Construct a map of char occurrences

  ## Examples

      iex> Aoc2.collate_id "abcdef"
      []

      iex> Aoc2.collate_id "bababc"
      [2, 3]

      iex> Aoc2.collate_id "abbcde"
      [2]

      iex> Aoc2.collate_id "abcccd"
      [3]

      iex> Aoc2.collate_id "aabcdd"
      [2]

      iex> Aoc2.collate_id "abcdee"
      [2]

      iex> Aoc2.collate_id "ababab"
      [3]

  """
  def collate_id(x) do
    x
    |> String.graphemes()
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.reduce(%{}, fn char, acc ->
      Map.put acc, char, (acc[char] || 0) + 1
    end)
    |> Enum.filter(fn {_, v} -> v == 2 or v == 3 end)
    |> Enum.group_by(fn t -> elem t, 1 end)
    |> Map.keys()
  end

  @doc """
  Compute the resulting checksums from an input file of box IDs.
  """
  def main(filepath) do
    filepath
    |> File.open!([:read])
    |> IO.read(:all)
    |> String.split(~r/\n/)
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(&collate_id/1)
    |> calc_checksums()
  end
  def main do
    IO.puts "Error: Please provide the path to the data file."
  end
end
