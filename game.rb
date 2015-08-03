require_relative 'board'
require 'yaml'

class MinesweeperGame
  attr_reader :board

  def initialize(file = nil, board = Board.create_board)
    @board = file.nil? ? board : YAML.load(File.read(file))
  end

  def save
    file = File.open("minesweeper.yaml", "w")
    file.write(board.to_yaml)
    file.close
  end

  def play
    until board.over?
      system("clear")
      board.render

      option, pos = prompt
      if option == "save"
        save
        next
      end

      return if option == "quit"

      option == "f" ? board[pos].flag : board[pos].reveal
    end

    system("clear")
    board.render
    game_over
  end

  def game_over
    puts (board.any_exploded_bomb? ? "BOOM! Game over" : "Good job. You win.")
  end

  def prompt
    puts "Where would you like to play? Enter form 'r1,2'."
    print "> "

    begin
      input = gets.chomp.downcase
      return input if ["quit", "save"].include?(input)
      parsed_input = parse(input)
      valid_check = valid_input?(parsed_input)
      puts "Enter a valid move (form 'r1,2'):" unless valid_check
    end until valid_check

    parsed_input
  end

  def valid_input?(parsed_input)
    return false if parsed_input.nil?
    option, position = parsed_input
    ["r", "f"].include?(option) && board.in_range?(position)
  end

  def parse(input)
    parsed = input.match /(\w)\s*(\d)\s*,\s*(\d)/
    parsed.nil? ? nil : [parsed.captures[0], parsed.captures[1..2].map(&:to_i)]
  end
end
