defmodule Day3 do
  def run do
    Day3.get_input
    |> process_input
    |> convert_string_sets_to_integer_sets
    |> sum_multiplication_sets
    |> IO.puts()
  end

  def get_input do
    # file_path = "./inputs/sample.txt"
    file_path = "./inputs/input.txt"
    elem(File.read(file_path), 1)
  end

  def process_input(raw_data) do
    multiplications = Regex.scan(~r/mul\(\d*,\d*\)/, raw_data)
    Enum.map(multiplications, fn set -> hd(Regex.scan(~r/(\d*),(\d*)/, hd(set), capture: :all_but_first)) end)
  end

  def convert_string_sets_to_integer_sets(sets) do
    Enum.map(sets, fn set ->
      Enum.map(set, fn num -> String.to_integer(num) end)
    end)
  end

  def sum_multiplication_sets(int_sets) do
    Enum.reduce(int_sets, 0, fn set, acc -> acc + (Enum.at(set, 0) * Enum.at(set, 1)) end)
  end
end
