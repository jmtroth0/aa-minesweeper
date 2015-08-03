require_relative 'board'

class MinesweeperGame
  attr_reader :board

  def initialize(board)
    @board = board
  end
end
