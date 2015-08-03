class Board
  SIZE = 9

  def initialize
    @board = Array.new(SIZE) { Array.new(SIZE) }
  end

  def populate(num_mines = SIZE)
    tiles = generated_tiles(num_mines)
  end

  def generated_tiles(num_mines)
    tiles = []

    total_tiles = SIZE * SIZE
    total_tiles.times do |i|
      tiles << ( i < num_mines ? Tile.new(true) : Tile.new )
    end

    tiles.shuffle
  end

  def [](pos)
    x, y = pos
    board[x][y]
  end

  def []=(pos, val)
    x, y = pos
    self.board[x][y] = val
  end
end
