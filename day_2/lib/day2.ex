defmodule Day2 do
  def run do
    Day2.get_input()
    |> process_input_to_integer_matrix
    |> solve
    |> IO.puts()
  end

  def get_input do
    # file_path = "./inputs/sample.txt"
    file_path = "./inputs/input.txt" # 498 too low. 472 is lower. 519 is too low still.
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
    first_try = if(descending_within_range?(list)) do
      true
    else
      descending_within_range?(Enum.reverse(list))
    end
    single_fault_tolerant_try = if(check_every_unsafe_level_for_tolerance(list)) do
      true
    else
      check_every_unsafe_level_for_tolerance(Enum.reverse(list))
    end
    first_try || single_fault_tolerant_try
  end

  def descending_within_range?(list) do
    truth_list = Enum.with_index(
      list,
      fn element, idx ->
        neighbor_difference = if idx < length(list) - 1 do
          element - Enum.at(list, idx + 1)
        else
          Enum.at(list, idx - 1) - element
        end
        neighbor_difference >= 1 && neighbor_difference <= 3
      end
    )
    Enum.all?(truth_list)
  end

  def check_every_unsafe_level_for_tolerance(list) do
    idx_eval_pair_list = Enum.with_index(
      list,
      fn element, idx ->
        neighbor_difference = if idx < length(list) - 1 do
          element - Enum.at(list, idx + 1)
        else
          Enum.at(list, idx - 1) - element
        end
        [idx, neighbor_difference >= 1 && neighbor_difference <= 3]
      end
    )
    failures = Enum.reject(idx_eval_pair_list, fn pair -> List.last(pair) == true end)
    lists_to_check = Enum.map(failures, fn pair -> List.delete_at(list, hd(pair)) end)
    Enum.any?(lists_to_check, fn li -> descending_within_range?(li) end)
  end
end
