# frozen_string_literal: true

require 'board'
require 'board_constants'

class Game
  include BoardConstants

  attr_reader :board

  def initialize(board = Board.new)
    @board = board
  end

  def player_turn
    loop do
      choice = verify_input(player_input)
      break if choice

      # Error message
    end
  end

  def verify_input(input)
    return input if valid_input?(input)
  end

  def run_round
    # set_current_player
    player_turn
    # drop_coordinates = drop(@choice, current_player.disc)
    # drops.push(drop_coordinates)
  end

  def run_round
    column_choice ||= gets.chomp
    return unless valid_input?(column_choice)

    drop_coordinates = drop(column_choice, 'disc')
    drops.push(drop_coordinates)
  end

  def valid_input?(input)
    (COL_LOWER_INDEX.to_s..COL_UPPER_INDEX.to_s).include?(input) &&
      board.valid_drop?(input.to_i)
  end

  private

  def player_input
    puts 'Choose a column row (between 0 and 6)'
    gets.chomp
  end

  # def drops
  #   @drops ||= []
  # end

  # def drop(column_num, disc)
  #   board.drop(column_num, disc)
  # end
end
