defmodule Day1Part2 do
  def run_solution do
    Day1Part2.get_input()
    |> process_input
    |> solve
    |> IO.puts()
  end

  def get_input do
    # file_path = "./inputs/sample.txt"
    file_path = "./inputs/input.txt"
    String.split(elem(File.read(file_path), 1), "\n", trim: true)
  end

  def process_input(raw_data) do
    Enum.map(raw_data, fn x -> String.split(x, "   ") end)
  end

  def solve(processed_data) do
    left_list = Enum.map(processed_data, fn x -> String.to_integer(hd(x)) end)
    right_list = Enum.map(processed_data, fn x -> String.to_integer(Enum.at(x, 1)) end)
    all_similarity_scores = Enum.map_every(left_list, 1, fn x -> Day1Part2.calculate_similarity_score(x, right_list) end)
    Enum.sum(all_similarity_scores)
  end

  def calculate_similarity_score(num, list) do
    count = Enum.count(list, fn x -> x === num end)
    num * count
  end
end
