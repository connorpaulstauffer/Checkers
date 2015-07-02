require_relative 'board'
require_relative 'player'

class CheckersGame
  attr_reader :board

  def initialize(players)
    @board = Board.new
    @players = players
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
