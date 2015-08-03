class Board
  SIZE = 9

  def initialize
    @board = Array.new(SIZE) { Array.new(SIZE) }
  end

  def populate(num_mines = SIZE)
    tiles = generated_tiles(num_mines)
  end
end
