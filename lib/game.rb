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
                 player1: Player.new(name: 'player1', disc: "\u{26AA}"),
                 player2: Player.new(name: 'player2', disc: "\u{26AB}"),
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
    run_round until game_over?
  end

  def game_over?
    winner? || draw?
  end

  def winner?
    board.last_disc_wins?
  end

  def winner
    current_player if winner?
  end

  def draw?
    board.full? && winner.nil?
  end

  def run_round
    players.run_round
    player_turn
    board.run_round(to_index(current_player_choice), current_player.disc)
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

  def valid_input?(input)
    (LOWER_INPUT..UPPER_INPUT).include?(input)
  end

  def to_index(input)
    input.to_i - 1
  end

  def current_player
    players.current
  end

  private

  def player_input(player = current_player)
    puts "#{player.name} (#{player.disc}), choose a column between #{LOWER_INPUT} and #{UPPER_INPUT} to drop your disc."
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
