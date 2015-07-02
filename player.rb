class HumanPlayer
  attr_reader :color

  def initialize(color, game)
    @color = color
    @game = game
  end

  def make_move
    action = $stdin.getch
    case action
    when "w"
      game.board.cursor_up
    when "a"
      game.board.cursor_left
    when "d"
      game.board.cursor_right
    when "s"
      game.board.cursor_down
    else
      false
    end
  end


end
