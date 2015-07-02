require 'io/console'

class HumanPlayer
  attr_reader :color
  attr_accessor :board, :game

  def initialize(color)
    @color = color
    @selected_pos = nil
  end

  def make_move
    input = process_input
    if input == :jump && board[*board.cursor_pos].valid_jumps.length > 0
      game.display
      @selected_pos = board.cursor_pos
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
      board.cursor_up
    when "a"
      board.cursor_left
    when "d"
      board.cursor_right
    when "s"
      board.cursor_down
    when "\r"
      if @selected_pos.nil?
        @selected_pos = board.cursor_pos
        p @selected_pos
      else
        move = board.move(@selected_pos, board.cursor_pos)
        @selected_pos = nil
        return move
      end
    else
      false
    end
    false
  end


end
