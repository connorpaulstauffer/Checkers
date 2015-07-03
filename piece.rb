require 'colorize'
require 'byebug'

class Piece
  attr_reader :color, :board
  attr_accessor :pos

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
    moves = map_to_moves(diffs)
    moves_to_empty(moves)
  end

  def valid_jumps
    diffs = diffs_on_board(jump_diffs)
    diffs = jumps_over_enemy(diffs)
    moves = map_to_moves(diffs)
    moves_to_empty(moves)
  end

  def jumps_over_enemy(diffs)
    diffs.select do |r_dx, c_dx|
      half_r_dx = r_dx  / r_dx.abs
      half_c_dx = c_dx / c_dx.abs
      board[pos.first + half_r_dx, pos.last + half_c_dx].color == other_color
    end
  end

  def map_to_moves(diffs)
    diffs.map { |r_dx, c_dx| [pos.first + r_dx, pos.last + c_dx] }
  end

  def moves_to_empty(moves)
    moves.select { |row, col| board[row, col].empty? }
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

  def valid_jumps_from(start_pos)
    new_board = board.dup
    new_board.move!(pos, start_pos)
    new_board[*start_pos].valid_jumps
  end

  def other_color
    (color == :red) ? :black : :red
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

  def king_me
    @kinged = true
  end

  def to_s
    if king?
      (color == :red) ? " #{"\u265A".red} " : " #{"\u265A".black} "
    else
      (color == :red) ? " #{"\u25C9".red} " : " #{"\u25C9".black} "
    end
  end

  def dup(new_board)
    Piece.new(color, pos.dup, new_board, king?)
  end

end

class EmptySquare

  def dup(new_board)
    EmptySquare.new
  end

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

  def color
    nil
  end

end
