require_relative 'board'
require_relative 'player'
require_relative 'display'

class CheckersGame
  attr_reader :board, :players, :display, :move_sequence

  def initialize
    @board = Board.new(self)
    @display = Display.new(self, board, [0, 0], true)
    @move_sequence = []
    setup_players
  end

  def play
    until over?
      display.render
      execute_move
      switch_players!
    end
    display.render
    puts "#{other_player.color.to_s.capitalize} has won!"
  end

  def execute_move
    loop do
      break if current_player.make_move_sequence

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

  def setup_players
    @players = [
      HumanPlayer.new(:black, self, display, board),
      HumanPlayer.new(:red, self, display, board)
    ]
  end

end

if __FILE__ == $PROGRAM_NAME
  game = CheckersGame.new
  game.play
end
