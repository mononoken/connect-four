# frozen_string_literal: true

require 'board'
require 'board_constants'
require 'player'

# Represents the game, Connect Four.
class Game
  include BoardConstants

  attr_reader :board, :player1, :player2
  attr_accessor :current_player

  def initialize(board = Board.new)
    @board = board
    @player1 = Player.new('player1', 'o')
    @player2 = Player.new('player2', 'x')
  end

  def player_turn
    loop do
      choice = verify_input(player_input)
      break if choice

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
    if current_player == player1
      self.current_player = player2
    else
      self.current_player = player1
    end
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
