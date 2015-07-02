require_relative 'piece'

class Board

  attr_reader :grid, :cursor_pos
  attr_accessor :game

  def initialize(grid = nil, cursor_pos = [0, 0])
    setup_grid(grid)
    @cursor_pos = cursor_pos
  end

  def move(start_pos, end_pos)
    return false unless self[*start_pos].color == current_player.color
    if self[*start_pos].valid_slides.include?(end_pos)
      move!(start_pos, end_pos)
      :slide
    elsif self[*start_pos].valid_jumps.include?(end_pos)
      self[*between(start_pos, end_pos)] = EmptySquare.new
      move!(start_pos, end_pos)
      :jump
    else
      false
    end
  end

  def move!(start_pos, end_pos)
    self[*end_pos] = self[*start_pos]
    self[*end_pos].pos = end_pos
    self[*start_pos] = EmptySquare.new
    self[*end_pos].king_me if reached_opponent_edge?(end_pos)
    true
  end

  def reached_opponent_edge?(end_pos)
    piece = self[*end_pos]
    (piece.color == :red) ? end_pos.first == 7 : end_pos.first == 0
  end

  def between(start_pos, end_pos)
    row_change = (end_pos.first - start_pos.first) / 2
    col_change = (end_pos.last - start_pos.last) / 2
    [start_pos.first + row_change, start_pos.last + col_change]
  end

  def valid_pos?(pos)
    pos.first.between?(0, 7) && pos.last.between?(0, 7)
  end

  def setup_grid(grid)
    if grid.nil?
      build_grid
    else
      @grid = grid
    end
  end

  def [](row, col)
    grid[row][col]
  end

  def []=(row, col, value)
    grid[row][col] = value
  end

  def build_grid
    @grid = Array.new(8) { Array.new(8) }
    [0, 1, 2].each { |row| @grid[row] = piece_row(row ,:red) }
    [5, 6, 7].each { |row| @grid[row] = piece_row(row, :black) }
    [3, 4].each { |row| @grid[row] = empty_row }
  end

  def piece_row(row, color)
    (0..7).map do |col|
      (col + row) % 2 == 0 ? Piece.new(color, [row, col], self) : EmptySquare.new
    end
  end

  def empty_row
    (0..7).map { EmptySquare.new }
  end

  def display
    puts render
  end

  def render
    grid.map.with_index do |row, r_idx|
      row.map.with_index do |el, c_idx|
        if [r_idx, c_idx] == cursor_pos
          el.to_s.colorize(background: :light_cyan)
        elsif cursor_pos && self[*cursor_pos].valid_moves.include?([r_idx, c_idx]) &&
              self[*cursor_pos].color == current_player.color
          el.to_s.colorize(background: :green)
        elsif (r_idx + c_idx) % 2 == 0
          el.to_s.colorize(background: :light_black)
        else
          el.to_s.colorize(background: :white)
        end
      end.join("")
    end.join("\n")
  end

  def cursor_up
    if cursor_pos && cursor_pos.first > 0
      @cursor_pos = [cursor_pos.first - 1, cursor_pos.last]
    end
  end

  def cursor_down
    if cursor_pos && cursor_pos.first < 7
      @cursor_pos = [cursor_pos.first + 1, cursor_pos.last]
    end
  end

  def cursor_left
    if cursor_pos && cursor_pos.last > 0
      @cursor_pos = [cursor_pos.first, cursor_pos.last - 1]
    end
  end

  def cursor_right
    if cursor_pos && cursor_pos.last < 7
      @cursor_pos = [cursor_pos.first, cursor_pos.last + 1]
    end
  end

  def current_player
    game.current_player
  end

  def other_player
    game.other_player
  end

  def loser
    return current_player if grid.flatten.none? { |piece| piece.color == current_player.color }
    return other_player if grid.flatten.none? { |piece| piece.color == other_player.color }
    nil
  end

  def inspect
    nil
  end

  protected

  attr_writer :grid


end
