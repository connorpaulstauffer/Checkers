require 'io/console'

class HumanPlayer
  attr_reader :color, :sequence
  attr_accessor :board, :game, :display

  def initialize(color, game, display, board)
    @color = color
    @game = game
    @display = display
    @board = board
    @sequence = []
  end

  def make_move_sequence
    loop do
      input = get_input
      if input == :enter
        if @sequence.last == display.cursor_pos
          valid = board.move(@sequence)
          @sequence = []
          display.reset_selected_pos
          return true if valid
        else
          @sequence << display.cursor_pos
          display.set_selected_pos
        end
      end
      display.render
    end
  end


  def get_input
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
      return :enter
    end
    false
  end


end
