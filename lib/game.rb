# frozen_string_literal: true

require 'board'

class Game
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
    @moves = []
  end

  def game_over?
    board.game_over?
  end
end
