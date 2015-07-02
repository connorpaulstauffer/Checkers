require 'io/console'

class HumanPlayer
  attr_reader :color
  attr_accessor :board

  def initialize(color)
    @color = color
  end

  def make_move
    action = $stdin.getch
    case action
    when "w"
      board.cursor_up
    when "a"
      board.cursor_left
    when "d"
      board.cursor_right
    when "s"
      board.cursor_down
    else
      false
    end
  end


end
