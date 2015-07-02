require_relative 'board'
require_relative 'player'

class CheckersGame
  attr_reader :board, :players

  def initialize(players)
    @board = Board.new
    @board.game = self
    @players = players
    players.each do |player|
      player.board = board
      player.game = self
    end
  end

  def play
    until over?
      display
      execute_move
      switch_player!
    end
    display
    puts "#{board.loser.color.to_s.capitalize} has lost!"
  end

  def execute_move
    loop do
      break if current_player.make_move
      display
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

  def switch_player!
    @players.reverse!
  end

  def display
    system('clear')
    board.display
    puts "#{current_player.color.to_s.capitalize}'s turn"
  end

end

if __FILE__ == $PROGRAM_NAME
  player1 = HumanPlayer.new(:red)
  player2 = HumanPlayer.new(:black)
  game = CheckersGame.new([player1, player2])
  game.play
end
