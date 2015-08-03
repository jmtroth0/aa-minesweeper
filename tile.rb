class Tile
  attr_reader :has_bomb, :has_flag, :revealed, :neighbors

  def initialize(bomb = false)
    @has_bomb = bomb
    @has_flag = false
    @revealed = false
    @neighbors = []
  end

  def bomb?
    has_bomb
  end

  def flagged?
    flag
  end

  def revealed?
    revealed
  end
end
