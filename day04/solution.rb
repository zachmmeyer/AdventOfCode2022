# frozen_string_literal: true

test_input = File.open('./test_input').read.split("\n")
puzzle_input = File.open('./puzzle_input').read.split("\n")

def create_array_of_ranges(input)
  range_array = []
  input.each do |string|
    string = string.gsub('-', ',').split(',')
    range_array.push((string[0].to_i..string[1].to_i).to_a, (string[2].to_i..string[3].to_i).to_a)
  end
  range_array
end

def arrange_pairs_small_to_large(input)
  sorted_array = []
  input.each_index do |index|
    next if index.odd?

    if input[index].size > input[index + 1].size
      sorted_array.push(input[index + 1], input[index])
    else
      sorted_array.push(input[index], input[index + 1])
    end
  end
  sorted_array
end

def count_pair_assignment_containment(input)
  number_of_full_containments = 0
  input.each_index do |index|
    next if index.odd?

    fully_overlapped = true
    input[index].each do |section|
      next if input[index + 1].include?(section)

      fully_overlapped = false
      break
    end
    number_of_full_containments += 1 if fully_overlapped == true
  end
  number_of_full_containments
end

def count_pair_overlaps(input)
  number_of_overlaps = 0
  input.each_index do |index|
    next if index.odd?

    input[index].each do |section|
      next unless input[index + 1].include?(section)

      number_of_overlaps += 1
      break
    end
  end
  number_of_overlaps
end

puts "Part 01 - Test Input: #{count_pair_assignment_containment(arrange_pairs_small_to_large(create_array_of_ranges(test_input)))}"
puts "Part 01 - Puzzle Input #{count_pair_assignment_containment(arrange_pairs_small_to_large(create_array_of_ranges(puzzle_input)))}"
puts "Part 02 - Test Input: #{count_pair_overlaps(arrange_pairs_small_to_large(create_array_of_ranges(test_input)))}"
puts "Part 02 - Puzzle #{count_pair_overlaps(arrange_pairs_small_to_large(create_array_of_ranges(puzzle_input)))}"
