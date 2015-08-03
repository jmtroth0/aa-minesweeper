require_relative 'board'

class MinesweeperGame
  attr_reader :board

  def initialize(board = Board.create_board)
    @board = board
  end

  def play
    until board.over?
      board.render
      option, pos = prompt
      option == 'f' ? board[pos].flag : board[pos].reveal
    end

    game_over
  end

  def prompt
  end

  def parse
  end
end
