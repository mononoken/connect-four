# frozen_string_literal: true

require_relative 'board'
require_relative 'board_visualizer'
require_relative 'board_constants'
require_relative 'player'

# Represents the game, Connect Four.
class Game
  include BoardConstants

  attr_reader :board, :players
  attr_accessor :current_player, :current_player_choice

  def initialize(board: Board.new,
                 player1: Player.new(name: 'player1', disc: 'o'),
                 player2: Player.new(name: 'player2', disc: 'x'))
    @board = board
    @players = [player1, player2]
  end

  def play
    setup
    run_rounds
    announce_results
  end

  # Wanting to see current player announced.
  def run_rounds
    until game_over?
      switch_current_player
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

  def run_round
    player_turn
    board.drop(current_player_choice.to_i, current_player.disc)
  end

  def player_turn
    loop do
      self.current_player_choice = verify_input(player_input)
      break if current_player_choice

      invalid_input
    end
  end

  def verify_input(input)
    return input if valid_input?(input)
  end

  def valid_input?(input)
    (COL_LOWER_INDEX.to_s..COL_UPPER_INDEX.to_s).include?(input) &&
      board.valid_drop?(input.to_i)
  end

  def switch_current_player
    self.current_player =
      case current_player
      when player1
        player2
      when player2
        player1
      when nil
        random_player
      end
  end

  def winner
    current_player if winner?
  end

  def random_player
    players[rand(players.count)]
  end

  def player1
    players[0]
  end

  def player2
    players[1]
  end

  private

  def player_input
    puts 'Choose a column between 0 and 6 to drop your disc.'
    gets.chomp
  end

  def invalid_input
    puts 'Invalid input! Choose a column between 0 and 6 to drop your disc.'
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
      Pick a column number (0, 1, 2... 6) to drop your disc in the column.
      Players will take turns dropping their discs on the board.
      You can make a row horizontally, vertically, and diagonally.
      When one player has four discs in a row they win!
    INSTRUCTIONS
  end
end
