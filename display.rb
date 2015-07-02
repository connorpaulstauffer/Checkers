class Display
  attr_accessor :game, :board, :cursor_pos, :selected_pos

  def initialize(game, board, cursor_pos = [0, 0])
    @game = game
    @board = board
    @cursor_pos = cursor_pos
    @selected_pos = nil
  end

  def render
    system('clear')
    puts board_string
    puts "#{game.current_player.color.to_s.capitalize}'s turn"
    p selected_pos
    p cursor_pos
  end

  def board_string
    board.grid.map.with_index do |row, r_idx|
      row.map.with_index do |el, c_idx|
        if [r_idx, c_idx] == cursor_pos
          el.to_s.colorize(background: :light_cyan)
        elsif cursor_pos && board[*cursor_pos].valid_moves.include?([r_idx, c_idx]) &&
              board[*cursor_pos].color == game.current_player.color
          el.to_s.colorize(background: :green)
        elsif (r_idx + c_idx) % 2 == 0
          el.to_s.colorize(background: :light_black)
        else
          el.to_s.colorize(background: :white)
        end
      end.join("")
    end.join("\n")
  end

  def set_selected_pos
    @selected_pos = @cursor_pos
  end

  def reset_selected_pos
    @selected_pos = nil
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

end
