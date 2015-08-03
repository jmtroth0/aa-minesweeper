class Tile
  attr_reader :has_bomb, :has_flag, :revealed, :neighbors, :neighbor_bomb_count

  def initialize(bomb = false)
    @has_bomb = bomb
    @has_flag = false
    @revealed = false
    @neighbors = []
    @neighbor_bomb_count = nil
  end

  def to_s
    if flagged?
      "F"
    elsif !revealed?
      "*"
    elsif neighbor_bomb_count == 0
      "_"
    else
      "#{neighbor_bomb_count}"
    end
  end

  def bomb?
    has_bomb
  end

  def flagged?
    has_flag
  end

  def revealed?
    revealed
  end

  def reveal
    revealed = true
  end

  def set_neighbor_bomb_count
    @neighbor_bomb_count = 0
    neighbors.each { |neighbor| @neighbor_bomb_count += 1 if neighbor.bomb? }
  end
end
