# frozen_string_literal: true

test_input = File.open('./test_input').read.split("\n")
puzzle_input = File.open('./puzzle_input').read.split("\n")

def most_calories(input, source)
  elf_index = 0
  elves = []
  input.each do |meal|
    if meal != ''
      elves[elf_index] = 0 if elves[elf_index].nil?
      elves[elf_index] += meal.to_i
    else
      elf_index += 1
    end
  end
  puts "Most calories: #{elves.max} (#{source})"
end

def top_three_calories(input, source)
  elf_index = 0
  elves = []
  input.each do |meal|
    if meal != ''
      elves[elf_index] = 0 if elves[elf_index].nil?
      elves[elf_index] += meal.to_i
    else
      elf_index += 1
    end
  end
  puts "Top three total: #{elves.max + elves.sort[-2] + elves.sort[-3]} (#{source})"
end

most_calories(test_input, 'test')
most_calories(puzzle_input, 'puzzle')
top_three_calories(test_input, 'test')
top_three_calories(puzzle_input, 'puzzle')
