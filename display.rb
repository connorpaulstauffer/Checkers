class Display
  attr_accessor :game, :board, :cursor_pos, :selected_pos, :debug

  def initialize(game, board, cursor_pos = [0, 0], debug = false)
    @game = game
    @board = board
    @cursor_pos = cursor_pos
    @selected_pos = nil
    @debug = debug
  end

  def render
    system('clear')
    puts board_string
    puts "#{game.current_player.color.to_s.capitalize}'s turn"
    if debug
      puts "Selected position: #{selected_pos}"
      puts "Cursor position: #{cursor_pos}"
      puts "Valid moves from selected: #{board[*selected_pos].valid_moves}" if selected_pos
      puts "Valid moves from cursor: #{board[*cursor_pos].valid_moves}"
      puts "Move sequence: #{game.current_player.sequence}"
    end
  end

  def board_string
    board.grid.map.with_index do |row, r_idx|
      row.map.with_index do |el, c_idx|
        if [r_idx, c_idx] == cursor_pos
          el.to_s.colorize(background: :light_cyan)
        # elsif just_jumped? && board[*game.current_player.sequence.last].valid_jumps.include?([r_idx, c_idx])
        #   el.to_s.colorize(background: :green)
        elsif selected_pos && board[*selected_pos].valid_moves.include?([r_idx, c_idx])
          el.to_s.colorize(background: :green)
        elsif !selected_pos && cursor_pos && board[*cursor_pos].valid_moves.include?([r_idx, c_idx]) &&
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

  # def just_jumped?
  #   sequence = game.current_player.sequence
  #   sequence.length > 1 && board[*sequence[-2]].valid_jumps.include?(sequence[-1])
  # end

  def set_selected_pos
    @selected_pos = @cursor_pos if board[*cursor_pos].color == game.current_player.color
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
