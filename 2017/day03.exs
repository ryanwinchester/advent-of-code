defmodule Day03 do
  @moduledoc """
  --- Day 3: Spiral Memory ---

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

  def steps_from(x) do
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
end


## Test
IO.puts Day03.steps_from(1) == 0
IO.puts Day03.steps_from(12) == 3
IO.puts Day03.steps_from(23) == 2
IO.puts Day03.steps_from(1024) == 31
