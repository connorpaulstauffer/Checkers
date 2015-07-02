require_relative 'board'
require_relative 'player'

class CheckersGame
  attr_reader :board, :players

  def initialize(players)
    @board = Board.new
    @players = players
    players.each { |player| player.board = board }
  end

  def play
    loop do
      display
      input = current_player.make_move
      break unless input
    end
  end

  def current_player
    @players.first
  end

  def display
    system('clear')
    board.display
  end

end

if __FILE__ == $PROGRAM_NAME
  player1 = HumanPlayer.new(:red)
  game = CheckersGame.new([player1])
  game.play
end
