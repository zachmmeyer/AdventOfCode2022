# frozen_string_literal: true

test_input = File.open('./test_input').read.split("\n")
puzzle_input = File.open('./puzzle_input').read.split("\n")

def find_duplicate_items_single_backpack(backpacks)
  duplicate_items = []
  backpacks.each do |backpack|
    divided_backpack = backpack.chars.each_slice(backpack.size / 2).to_a
    divided_backpack[0].each do |item|
      next unless divided_backpack[1].include?(item)

      duplicate_items.push(item)
      break
    end
  end
  duplicate_items
end

def calculate_item_priority(items)
  total_priority = 0
  priority_array = ('a'..'z').to_a + ('A'..'Z').to_a
  items.each do |item|
    total_priority += priority_array.index(item) + 1 if priority_array.include?(item)
  end
  puts "Total Priority: #{total_priority}"
end

def group_elves_into_threes(backpacks)
  backpacks.each_slice(3).to_a
end

def find_duplicate_items_three_backpacks(backpacks)
  duplicate_items = []
  backpacks.each do |backpack|
    backpack[0].chars.each do |item|
      next unless backpack[1].include?(item) && backpack[2].include?(item)

      duplicate_items.push(item)
      break
    end
  end
  duplicate_items
end

print 'Part 01 - Test Input: '
calculate_item_priority(find_duplicate_items_single_backpack(test_input))
print 'Part 01 - Puzzle Input: '
calculate_item_priority(find_duplicate_items_single_backpack(puzzle_input))
print 'Part 02 - Test Input: '
calculate_item_priority(find_duplicate_items_three_backpacks(group_elves_into_threes(test_input)))
print 'Part 02 - Puzzle Input: '
calculate_item_priority(find_duplicate_items_three_backpacks(group_elves_into_threes(puzzle_input)))
