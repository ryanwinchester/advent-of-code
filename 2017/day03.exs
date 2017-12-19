defmodule Day03 do
  @moduledoc """
  --- Day 3: Spiral Memory ---
  """

  @doc """
  You come across an experimental new kind of memory stored on an infinite
  two-dimensional grid.

  Each square on the grid is allocated in a spiral pattern starting at a
  location marked 1 and then counting up while spiraling outward.

  For example, the first few squares are allocated like this:

      17  16  15  14  13
      18   5   4   3  12
      19   6   1   2  11
      20   7   8   9  10
      21  22  23  24  -> ...

  While this is very space-efficient (no squares are skipped), requested data
  must be carried back to square 1 (the location of the only access port for
  this memory system) by programs that can only move up, down, left, or right.
  They always take the shortest path: the Manhattan Distance between the
  location of the data and square 1.

  For example:

  - Data from square 1 is carried 0 steps, since it's at the access port.
  - Data from square 12 is carried 3 steps, such as: down, left, left.
  - Data from square 23 is carried only 2 steps: up twice.
  - Data from square 1024 must be carried 31 steps.

  How many steps are required to carry the data from the square identified in
  your puzzle input all the way to the access port?
  """
  def part1(x) do
    matrix = get_n(x) |> build_matrix()
    {x0, y0} = Map.get(matrix, 1)
    {x, y} = Map.get(matrix, x)
    abs(x - x0) + abs(y - y0)
  end

  defp get_n(x) do
    sqrt = :math.sqrt(x) |> Float.ceil() |> trunc()
    if rem(sqrt, 2) == 0, do: sqrt + 1, else: sqrt
  end

  defp build_matrix(n) do
    for i <- 0..(n-1), j <- 0..(n-1), into: %{} do
      x = min(min(i, j), min(n-1-i, n-1-j))
      {cell(n, x, i, j), {i, j}}
    end
  end

  defp cell(n, x, i, j) when i <= j, do: (n-2*x)*(n-2*x) - (i-x) - (j-x)

  defp cell(n, x, i, j), do: (n-2*x-2)*(n-2*x-2) + (i-x) + (j-x)

  @doc """
  As a stress test on the system, the programs here clear the grid and then
  store the value 1 in square 1. Then, in the same allocation order as shown
  above, they store the sum of the values in all adjacent squares, including
  diagonals.

  So, the first few squares' values are chosen as follows:

  - Square 1 starts with the value 1.
  - Square 2 has only one adjacent filled square (with value 1), so it also
    stores 1.
  - Square 3 has both of the above squares as neighbors and stores the sum of their values, 2.
  - Square 4 has all three of the aforementioned squares as neighbors and stores the sum of their values, 4.
  - Square 5 only has the first and fourth squares as neighbors, so it gets the value 5.

  Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:

      147  142  133  122   59
      304    5    4    2   57
      330   10    1    1   54
      351   11   23   25   26
      362  747  806--->   ...

  What is the first value written that is larger than your puzzle input?
  """
  def part2(x) do
  end
end


## Test - Part 1
IO.puts "--- part 1 ---"
IO.puts Day03.part1(1) == 0
IO.puts Day03.part1(12) == 3
IO.puts Day03.part1(23) == 2
IO.puts Day03.part1(1024) == 31

## Test - Part 2
IO.puts "--- part 2 ---"
IO.inspect Day03.part2()
