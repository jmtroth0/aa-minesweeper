require_relative 'tile'

class Board
  SIZE = 9
  NEIGHBOR_OFFSETS = [
    [1, 1],
    [0, 1],
    [-1, 1],
    [1, 0],
    [-1, 0],
    [1, -1],
    [0, -1],
    [-1, -1]
  ]

  attr_reader :num_mines
  attr_accessor :board

  def self.create_board(size = SIZE, num_mines = SIZE)
    board = Board.new(size, num_mines)
    board.populate
    board
  end

  def initialize(size = SIZE, num_mines = SIZE)
    @board = Array.new(size) { Array.new(size) }
    @num_mines = num_mines
  end

  def render
    board.each { |row| puts row.join(" ") }

    nil
  end

  def reveal(pos) #recursive
    self[pos].reveal
  end

  def populate
    tiles = generated_tiles(num_mines)

    all_positions.each { |pos| self[pos] = tiles.shift }
    set_tile_neighbors

    nil
  end

  def set_tile_neighbors
    all_positions.each do |x, y|
      NEIGHBOR_OFFSETS.each do |dx, dy|
        offset_pos = [x + dx, y + dy]
        tile = self[[x, y]]

        tile.neighbors << self[[x + dx, y + dy]] if in_range?(offset_pos)

        tile.set_neighbor_bomb_count
      end
    end
  end

  def all_positions
    positions = []

    board.each_with_index do |row, x|
      row.each_index do |y|
        positions << [x, y]
      end
    end

    positions
  end

  def generated_tiles(num_mines)
    tiles = []

    total_tiles = SIZE * SIZE
    total_tiles.times do |i|
      tiles << ( i < num_mines ? Tile.new(true) : Tile.new )
    end

    tiles.shuffle
  end

  def over?
    any_exploded_bomb? || mines_swept?
  end

  def any_exploded_bomb?
    board.flatten.any? { |tile| tile.revealed? && tile.bomb? }
  end

  def mines_swept?
    board.flatten.reject { |tile| tile.revealed? }.count == num_mines
  end

  def in_range?(pos)
    pos.all? { |coord| coord.between?(0, SIZE - 1) }
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
