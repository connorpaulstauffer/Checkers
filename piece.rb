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
    diffs.map! do |r_change, c_change|
      [pos.first + r_change, pos.last + c_change]
    end
    diffs.select { |row, col| board[row, col].empty? }
  end

  def valid_jumps
    diffs = diffs_on_board(jump_diffs)
    diffs.select! do |row_change, col_change|
      half_row_change = row_change  / row_change.abs
      half_col_change = col_change / col_change.abs
      board[pos.first + half_row_change, pos.last + half_col_change].color == other_color
    end
    diffs.map! do |r_change, c_change|
      [pos.first + r_change, pos.last + c_change]
    end
    diffs.select do |row, col|
      board[row, col].empty?
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

  def to_s
    if king?
      (color == :red) ? " #{"\u265A".red} " : " #{"\u265A".black} "
    else
      (color == :red) ? " #{"\u25C9".red} " : " #{"\u25C9".black} "
    end
  end

  def king_me
    @kinged = true
    puts "kinged"
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

  def color
    nil
  end

end
