defmodule Day2 do
  def run do
    Day2.get_input()
    |> process_input_to_integer_matrix
    |> solve
    |> IO.puts()
  end

  def get_input do
    # file_path = "./inputs/sample.txt"
    file_path = "./inputs/input.txt" # 494 too high
    String.split(elem(File.read(file_path), 1), "\n", trim: true)
  end

  def process_input_to_integer_matrix(raw_data) do
    string_matrix = Enum.map(raw_data, fn x -> String.split(x, " ") end)

    Enum.map_every(string_matrix, 1, fn row ->
      Enum.map(row, fn str -> String.to_integer(str) end)
    end)
  end

  def solve(matrix) do
    Enum.reduce(matrix, 0, (fn row, acc -> if(is_safe?(row), do: acc + 1, else: acc) end))
  end

  def is_safe?(list) do
    first_try = descending_within_range?(list)
    if(first_try, do: true, else: descending_within_range?(Enum.reverse(list)))
  end

  def descending_within_range?(list) do
    truth_list = Enum.with_index(
      list,
      fn element, idx ->
        neighbor_difference = if idx < 4 do
          element - Enum.at(list, idx + 1)
        else
          Enum.at(list, idx - 1) - element
        end
        neighbor_difference >= 1 && neighbor_difference <= 3
      end
    )
    Enum.all?(truth_list)
  end
end
