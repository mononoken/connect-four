# frozen_string_literal: true

require 'board'

class Game
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
  end

  def valid_move?(column_num)
    !board.column_full?(column_num)
  end
end
