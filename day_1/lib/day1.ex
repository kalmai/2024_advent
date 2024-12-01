defmodule Day1 do
  def run_solution do
    Day1.get_input() |> process_input |> sort_data |> calculate_answer |> IO.puts()
  end

  def get_input do
    # file_path = "./inputs/sample.txt"
    file_path = "./inputs/input.txt"
    String.split(elem(File.read(file_path), 1), "\n", trim: true)
  end

  def process_input(raw_data) do
    Enum.map(raw_data, fn x -> String.split(x, "   ") end)
  end

  def sort_data(processed_data) do
    left_list = Enum.sort(Enum.map(processed_data, fn x -> String.to_integer(hd(x)) end))
    right_list = Enum.sort(Enum.map(processed_data, fn x -> String.to_integer(Enum.at(x, 1)) end))
    Enum.with_index(left_list, fn x, idx -> [x, Enum.at(right_list, idx)] end)
  end

  def calculate_answer(sorted_data) do
    Enum.reduce(sorted_data, 0, fn x, acc -> acc + Day1.calculate_pair(x) end)
  end

  def calculate_pair(pair) do
    abs Enum.at(pair, 0) - Enum.at(pair, 1)
  end
end
