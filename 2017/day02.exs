defmodule Day02 do
  @moduledoc """
  --- Day 2: Corruption Checksum ---
  """

  @doc """
  As you walk through the door, a glowing humanoid shape yells in your direction.
  "You there! Your state appears to be idle. Come help us repair the corruption
  in this spreadsheet - if we take another millisecond, we'll have to display an
  hourglass cursor!"

  The spreadsheet consists of rows of apparently-random numbers. To make sure the
  recovery process is on the right track, they need you to calculate the
  spreadsheet's **checksum**. For each row, determine the difference between the
  largest value and the smallest value; the checksum is the sum of all of these
  differences.

  For example, given the following spreadsheet:

      5 1 9 5
      7 5 3
      2 4 6 8

  - The first row's largest and smallest values are `9` and `1`, and their difference is `8`.
  - The second row's largest and smallest values are `7` and `3`, and their difference is `4`.
  - The third row's difference is `6`.

  In this example, the spreadsheet's checksum would be `8 + 4 + 6 = 18`.

  """
  def part1(sheet) when is_binary(sheet) do
    sheet
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(&row_to_int/1)
    |> Enum.map(&checksum_row/1)
    |> Enum.sum()
  end

  def row_to_int(row), do: Enum.map(row, &String.to_integer/1)

  def checksum_row(row), do: Enum.max(row) - Enum.min(row)

  @doc """
  "Great work; looks like we're on the right track after all. Here's a star for
  your effort." However, the program seems a little worried. Can programs *be*
  worried?

  "Based on what we're seeing, it looks like all the User wanted is some
  information about the **evenly divisible values** in the spreadsheet.
  Unfortunately, none of us are equipped for that kind of calculation - most of
  us specialize in bitwise operations."

  It sounds like the goal is to find the only two numbers in each row where one
  evenly divides the other - that is, where the result of the division operation
  is a whole number. They would like you to find those numbers on each line,
  divide them, and add up each line's result.

  ## For example, given the following spreadsheet:

      5 9 2 8
      9 4 7 3
      3 8 6 5

  - In the first row, the only two numbers that evenly divide are `8` and `2`;
    the result of this division is `4`.
  - In the second row, the two numbers are `9` and `3`; the result is `3`.
  - In the third row, the result is `2`.

  In this example, the sum of the results would be `4 + 3 + 2 = 9`.

  """
  def part2(sheet) when is_binary(sheet) do
    sheet
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(&row_to_int/1)
    |> Enum.map(&checksum_row2/1)
    |> Enum.sum()
  end

  defp checksum_row2(row) do
    for i <- row, j <- row, i != j do
      case {rem(i, j), rem(j, i)} do
        {0, _} -> div(i, j)
        {_, 0} -> div(j, i)
        _ -> 0
      end
    end
    |> Enum.filter(&(&1 > 0))
    |> Enum.at(0)
  end
end


## Test - Part 1
IO.puts("--- part 1 ---")
IO.puts Day02.part1("5 1 9 5\n7 5 3\n2 4 6 8") == 18

## Test - Part 2
IO.puts("--- part 2 ---")
IO.inspect Day02.part2("5 9 2 8\n9 4 7 3\n3 8 6 5") == 9
