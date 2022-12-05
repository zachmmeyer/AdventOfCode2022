# frozen_string_literal: true

test_input = File.open('./test_input').read.split("\n")
puzzle_input = File.open('./puzzle_input').read.split("\n")

def parse_input_crates(input)
  parsed_crate_input = input.map do |string|
    next if string.include?('move') || string.include?('1') || string == ''

    string.gsub('    ', '-').gsub(' ', '-').delete('[').delete(']').split('-')
  end.compact

  parsed_crate_input.each do |line|
    line.push('') while line.length < parsed_crate_input.last.length
  end
end

def parse_input_rows(input)
  parsed_row_input = input.map do |string|
    next if string.include?('[') || string.include?('move') || string == ''

    string.lstrip.split(' ')
  end
  parsed_row_input.compact.last.last.to_i
end

def parse_input_instructions(input)
  input.map do |string|
    next if string.include?('[') || string == '' || string[0] == ' '

    string.gsub('move', '').gsub('from', '').gsub('to', '').split(' ')
  end.compact
end

def find_top_crate(crates, column)
  crates.each_with_index do |row, index|
    return row[column - 1], index, column - 1 if row[column - 1] != ''
  end
end

def find_bottom_crate(crates, column, moves)
  crates.each_with_index do |row, index|
    next if row[column - 1] == ''

    moves -= 1
    if (moves.zero? && row[column - 1] != '') || (crates[index + 1][column - 1] == '')
      return row[column - 1], index, column - 1
    end
  end
end

def add_row_maybe(crates, column, rows)
  space_available = false
  crates.reverse_each do |row|
    next if row[column] != ''

    space_available = true
    break
  end
  crates.unshift(Array.new(rows, '')) if space_available == false
  crates
end

def process_crate_instructions(crates, instructions, rows)
  instructions.each do |instruction|
    instruction[0].to_i.times do
      selected_crate, crate_location0, crate_location1 = find_top_crate(crates, instruction[1].to_i)
      crates[crate_location0][crate_location1] = ''
      crates = add_row_maybe(crates, (instruction[2].to_i - 1), rows)
      crates.reverse_each do |crate|
        slot_found = false
        crate.each_with_index do |slot, crate_index|
          next if crate_index != (instruction[2].to_i - 1)

          if slot == ''
            crate[crate_index] = selected_crate
            slot_found = true
            break
          end
        end
        break if slot_found == true
      end
    end
  end
  crates
end

def process_crate_instructions_but_worse(crates, instructions, rows)
  instructions.each do |instruction|
    instruction[0].to_i.times do
      selected_crate, crate_location0, crate_location1 = find_bottom_crate(crates, instruction[1].to_i, instruction[0].to_i)
      crates[crate_location0][crate_location1] = ''
      crates = add_row_maybe(crates, (instruction[2].to_i - 1), rows)
      crates.reverse_each do |crate|
        slot_found = false
        crate.each_with_index do |slot, crate_index|
          next if crate_index != (instruction[2].to_i - 1)

          if slot == ''
            crate[crate_index] = selected_crate
            slot_found = true
            break
          end
        end
        break if slot_found == true
      end
    end
  end
  crates
end

def print_top_stack_crates(crates, rows)
  top_stacks = ''
  rows.times do |row|
    crates.each do |crate|
      next if crate[row] == ''

      top_stacks += crate[row]
      break
    end
  end
  top_stacks
end

parsed_crates = parse_input_crates(test_input)
parsed_instructions = parse_input_instructions(test_input)
parsed_rows = parse_input_rows(test_input)
moved_crates = process_crate_instructions(parsed_crates, parsed_instructions, parsed_rows)
puts "Part 01 - Test Input: #{print_top_stack_crates(moved_crates, parsed_rows)}"

parsed_crates = parse_input_crates(puzzle_input)
parsed_instructions = parse_input_instructions(puzzle_input)
parsed_rows = parse_input_rows(puzzle_input)
moved_crates = process_crate_instructions(parsed_crates, parsed_instructions, parsed_rows)
puts "Part 01 - Puzzle Input: #{print_top_stack_crates(moved_crates, parsed_rows)}"

parsed_crates = parse_input_crates(test_input)
parsed_instructions = parse_input_instructions(test_input)
parsed_rows = parse_input_rows(test_input)
moved_crates = process_crate_instructions_but_worse(parsed_crates, parsed_instructions, parsed_rows)
puts "Part 02 - Test Input: #{print_top_stack_crates(moved_crates, parsed_rows)}"

parsed_crates = parse_input_crates(puzzle_input)
parsed_instructions = parse_input_instructions(puzzle_input)
parsed_rows = parse_input_rows(puzzle_input)
moved_crates = process_crate_instructions_but_worse(parsed_crates, parsed_instructions, parsed_rows)
puts "Part 02 - Puzzle Input: #{print_top_stack_crates(moved_crates, parsed_rows)}"
