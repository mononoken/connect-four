# frozen_string_literal: true

require_relative 'board'
require_relative 'board_constants'
require_relative 'player'
require_relative 'players'

# Represents the game, Connect Four.
class Game
  include BoardConstants

  attr_reader :board, :players
  attr_accessor :current_player_choice

  def initialize(board: Board.new,
                 player1: Player.new(name: 'player1', disc: 'o'),
                 player2: Player.new(name: 'player2', disc: 'x'),
                 players: Players.new(player1: player1, player2: player2))
    @board = board
    @players = players
  end

  def play
    setup
    run_rounds
    announce_results
  end

  def run_rounds
    until game_over?
      players.swap_current
      run_round
      show_board
    end
  end

  def game_over?
    winner? || draw?
  end

  # This seems a bit disconnected in deciding WHO the winner is.
  # See #winner as well.
  def winner?
    board.any_wins?
  end

  def draw?
    board.full? && winner.nil?
  end

  # I think run_round should be the contents of run_rounds
  # This should be renamed and containe within it
  def run_round
    player_turn
    board.drop(to_index(current_player_choice), current_player.disc)
  end

  def player_turn
    loop do
      self.current_player_choice = verify_input(player_input)
      break if current_player_choice

      invalid_input
    end
  end

  def verify_input(input)
    return input if valid_input?(input) && board.valid_drop?(to_index(input))
  end

  def valid_input?(input, lower_limit: LOWER_INPUT, upper_limit: UPPER_INPUT)
    (lower_limit..upper_limit).include?(input)
  end

  def winner
    current_player if winner?
  end

  def random_player
    players.random_player
  end

  def to_index(input)
    input.to_i - 1
  end

  def current_player
    players.current
  end

  private

  def player_input(player_name = current_player.name)
    puts "#{player_name}, choose a column between #{LOWER_INPUT} and #{UPPER_INPUT} to drop your disc."
    gets.chomp
  end

  def invalid_input
    puts 'Invalid input!'
  end

  def setup
    puts instructions
    show_board
  end

  def show_board
    puts board.display
  end

  def announce_results
    if winner?
      announce_winner
    elsif draw?
      puts 'Stalemate.'
    end
  end

  def announce_winner(winner = self.winner)
    puts "#{winner.name} wins!"
  end

  def instructions
    <<~INSTRUCTIONS
      Welcome to Connect Four!
      Pick a column number to drop your disc in the column.
      Players will take turns dropping their discs on the board.
      You can make a row horizontally, vertically, and diagonally.
      When one player has four discs in a row they win!
    INSTRUCTIONS
  end
end
