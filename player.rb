require 'io/console'

class HumanPlayer
  attr_reader :color
  attr_accessor :board, :game, :display

  def initialize(color, game, display, board)
    @color = color
    @game = game
    @display = display
    @board = board
  end

  def make_move
    input = process_input
    if input == :jump && board[*display.cursor_pos].valid_jumps.length > 0
      display.render
      display.set_selected_pos
      make_move
    else
      return input
    end
  end

  def process_input
    action = $stdin.getch
    case action
    when "q"
      exit
    when "w"
      display.cursor_up
    when "a"
      display.cursor_left
    when "d"
      display.cursor_right
    when "s"
      display.cursor_down
    when "\r"
      if display.selected_pos.nil?
        display.set_selected_pos
      else
        move = board.move(display.selected_pos, display.cursor_pos)
        display.reset_selected_pos
        return move
      end
    else
      false
    end
    false
  end


end
