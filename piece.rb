require 'colorize'
require 'byebug'

class Piece
  attr_reader :color, :pos, :board

  def initialize(color, pos, board, kinged = false)
    @color = color
    @pos = pos
    @kinged = kinged
    @board = board
  end

  def valid_moves
    valid_slides + valid_jumps
  end

  def valid_slides
    diffs = diffs_on_board(slide_diffs)
    diffs.map do |r_change, c_change|
      [pos.first + r_change, pos.last + c_change]
    end
  end

  def valid_jumps
    diffs = diffs_on_board(jump_diffs)
    diffs.map do |r_change, c_change|
      [pos.first + r_change, pos.last + c_change]
    end
  end

  def slide_diffs
    forward = (color == :red) ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
    backward = (color == :red) ? [[-1, 1], [-1, -1]] : [[1, 1], [1, -1]]
    king? ? forward + backward : forward
  end

  def jump_diffs
    forward = (color == :red) ? [[2, 2], [2, -2]] : [[-2, 2], [-2, -2]]
    backward = (color == :red) ? [[-2, 2], [-2, -2]] : [[2, 2], [2, -2]]
    king? ? forward + backward : forward
  end

  def diffs_on_board(diffs)
    diffs.select do |r_change, c_change|
      board.valid_pos?([pos.first + r_change, pos.last + c_change])
    end
  end

  def king?
    @kinged
  end

  def empty?
    false
  end

  def piece?
    true
  end

  def to_s
    (color == :red) ? " #{"\u25C9".red} " : " #{"\u25C9".black} "
  end

end

class EmptySquare

  def empty?
    true
  end

  def piece?
    false
  end

  def to_s
    "   "
  end

  def valid_moves
    []
  end

end
