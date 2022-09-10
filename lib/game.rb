# frozen_string_literal: true

require 'board'
require 'board_constants'
require 'player'

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

  def run_round
    # player_turn
    # board.drop(current_player_choice, current_player.disc)
    board.drop(3, 'x')
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
      end
  end

  def choose_current_player(player)
    self.current_player = player
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
end
