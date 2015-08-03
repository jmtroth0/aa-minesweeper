require 'byebug'

class Tile
  attr_reader :has_bomb, :neighbors, :neighbor_bomb_count
  attr_accessor :revealed, :has_flag

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
    elsif !bomb?
      "#{neighbor_bomb_count}"
    else
      "B"
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

  def flag
    # debugger
    self.has_flag = !has_flag
    p "Flag is: #{has_flag}"
  end

  def reveal
    return nil if flagged?

    queue = [self]
    already_revealed = []

    until queue.empty?
      current_tile = queue.shift
      current_tile.revealed = true
      already_revealed << current_tile

      if current_tile.neighbor_bomb_count == 0
        current_tile.neighbors.each do |neighbor|
          queue << neighbor unless already_revealed.include?(neighbor)
        end
      end
    end

    nil
  end

  def set_neighbor_bomb_count
    @neighbor_bomb_count = 0
    neighbors.each { |neighbor| @neighbor_bomb_count += 1 if neighbor.bomb? }
  end
end
