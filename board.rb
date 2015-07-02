class Board

  def initialize(grid = nil)
    setup_grid(grid)
  end

  def setup_grid(grid)
    if grid.nil?
      build_grid
    else
      @grid = grid
    end
  end

  def build_grid
    @grid = Array.new(8) { Array.new(8) }
    [0, 1, 2].each { |row| @grid[row] = piece_row(row ,:red) }
    [5, 6, 7].each { |row| @grid[row] = piece_row(row, :red) }
    [3, 4].each { |row| @grid[row] = empty_row }
  end

  def piece_row(row, color)
    (0..7).map do |col|
      (col + row) % 2 == 0 ? Piece.new(:color, [row, col]) : EmptySquare.new
    end
  end

  def empty_row
    (0..7).map { EmptySquare.new }
  end


end
