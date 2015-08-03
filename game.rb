require_relative 'board'

class MinesweeperGame
  attr_reader :board

  def initialize(board = Board.create_board)
    @board = board
  end

  def play
    until board.over?
      system("clear")
      board.render
      option, pos = prompt
      option == 'f' ? board[pos].flag : board[pos].reveal
    end

    system("clear")
    board.render
    game_over
  end


  def prompt
    puts "Where would you like to play? Enter form 'r1,2'."
    print "> "

    begin
      input = gets.chomp.downcase
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
