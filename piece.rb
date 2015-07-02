class Piece

  attr_reader :color, :pos

  def initialize(color, pos)
    @color = color
    @pos = pos
  end

  def empty?
    false
  end

  def piece?
    true
  end

  def to_s
    (color == :red) ? "\u25C9".red : "\u25C9".black
  end

end

class EmptySquare

  def empty?
    true
  end

  def piece?
    false
  end

end
