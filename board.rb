require_relative 'piece'

class Board

  attr_reader :grid, :cursor_pos

  def initialize(grid = nil, cursor_pos = [0, 0])
    setup_grid(grid)
    @cursor_pos = cursor_pos
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

  def build_grid
    @grid = Array.new(8) { Array.new(8) }
    [0, 1, 2].each { |row| @grid[row] = piece_row(row ,:red) }
    [5, 6, 7].each { |row| @grid[row] = piece_row(row, :black) }
    [3, 4].each { |row| @grid[row] = empty_row }
  end

  def piece_row(row, color)
    (0..7).map do |col|
      (col + row) % 2 == 0 ? Piece.new(color, [row, col]) : EmptySquare.new
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
        elsif (r_idx + c_idx) % 2 == 0
          el.to_s.colorize(background: :white)
        else
          el.to_s.colorize(background: :light_black)
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

  def inspect
    nil
  end


end
