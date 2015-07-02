require_relative 'board'
require_relative 'player'
require_relative 'display'

class CheckersGame
  attr_reader :board, :players, :display

  def initialize
    @board = Board.new(self)
    @display = Display.new(self, board)
    setup_players
  end

  def setup_players
    @players = [
                 HumanPlayer.new(:black, self, display, board),
                 HumanPlayer.new(:red, self, display, board)
                ]
  end

  def play
    until over?
      display.render
      execute_move
      switch_players!
    end
    display
    puts "#{board.loser.color.to_s.capitalize} has lost!"
  end

  def execute_move
    loop do
      break if current_player.make_move
      display.render
    end
  end

  def over?
    !board.loser.nil?
  end

  def current_player
    @players.first
  end

  def other_player
    @players.last
  end

  def switch_players!
    @players.reverse!
  end

end

if __FILE__ == $PROGRAM_NAME
  game = CheckersGame.new
  game.play
end
