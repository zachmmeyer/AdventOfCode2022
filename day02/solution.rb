# frozen_string_literal: true

test_input = File.open('./test_input').read.split("\n")
puzzle_input = File.open('./puzzle_input').read.split("\n")

def parse_opponent_choice(opponent_input)
  opponent_choices = {
    'A' => 'Rock',
    'B' => 'Paper',
    'C' => 'Scissors'
  }
  opponent_choices[opponent_input]
end

def parse_player_choice(player_input)
  player_choices = {
    'X' => 'Rock',
    'Y' => 'Paper',
    'Z' => 'Scissors'
  }
  player_choices[player_input]
end

def parse_round_strategy(player_input)
  round_strategy = {
    'X' => 'lose',
    'Y' => 'draw',
    'Z' => 'win'
  }
  round_strategy[player_input]
end

def round_strategy_guide(round_strategy, opponent_choice)
  if round_strategy == 'win'
    if opponent_choice == 'Rock'
      'Paper'
    elsif opponent_choice == 'Paper'
      'Scissors'
    else
      'Rock'
    end
  elsif round_strategy == 'lose'
    if opponent_choice == 'Rock'
      'Scissors'
    elsif opponent_choice == 'Paper'
      'Rock'
    else
      'Paper'
    end
  else
    opponent_choice
  end
end

def parse_choice_value(choice)
  choice_value_hash = {
    'Rock' => 1,
    'Paper' => 2,
    'Scissors' => 3
  }
  choice_value_hash[choice]
end

def round_outcome(opponent_choice, player_choice)
  rps_hash = {
    'Rock' => 'Scissors',
    'Scissors' => 'Paper',
    'Paper' => 'Rock'
  }
  if rps_hash[player_choice] == opponent_choice
    6
  elsif rps_hash[opponent_choice] == player_choice
    0
  else
    3
  end
end

def rock_paper_scissors_part_01(input)
  score = 0
  input.each do |round|
    opponent_choice = parse_opponent_choice(round.chars.first)
    player_choice = parse_player_choice(round.chars.last)
    score += parse_choice_value(player_choice)
    score += round_outcome(opponent_choice, player_choice)
  end
  score
end

def rock_paper_scissors_part_02(input)
  score = 0
  input.each do |round|
    opponent_choice = parse_opponent_choice(round.chars.first)
    round_strategy = parse_round_strategy(round.chars.last)
    player_choice = round_strategy_guide(round_strategy, opponent_choice)
    score += parse_choice_value(player_choice)
    score += round_outcome(opponent_choice, player_choice)
  end
  score
end

puts "Part 01 - Test Input: #{rock_paper_scissors_part_01(test_input)}"
puts "Part 01 - Puzzle Input: #{rock_paper_scissors_part_01(puzzle_input)}"
puts '-' * 10
puts "Part 02 - Test Input: #{rock_paper_scissors_part_02(test_input)}"
puts "Part 02 - Puzzle Input: #{rock_paper_scissors_part_02(puzzle_input)}"
