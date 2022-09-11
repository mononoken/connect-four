# frozen_string_literal: true

require_relative 'board'

# Visual display of Board for Connect Four.
class BoardVisualizer
  attr_reader :board

  def initialize(board:)
    @board = board
  end

  def converted_data
    
  end

  ### Convert nils into spaces
  def display
    <<~EMPTY_TEMPLATE
      |#{board.column(0).space(5)}|#{board.column(1).space(5)}|#{board.column(2).space(5)}|#{board.column(3).space(5)}|#{board.column(4).space(5)}|#{board.column(5).space(5)}|#{board.column(6).space(5)}|
      |#{board.column(0).space(4)}|#{board.column(1).space(4)}|#{board.column(2).space(4)}|#{board.column(3).space(4)}|#{board.column(4).space(4)}|#{board.column(5).space(4)}|#{board.column(6).space(4)}|
      |#{board.column(0).space(3)}|#{board.column(1).space(3)}|#{board.column(2).space(3)}|#{board.column(3).space(3)}|#{board.column(4).space(3)}|#{board.column(5).space(3)}|#{board.column(6).space(3)}|
      |#{board.column(0).space(2)}|#{board.column(1).space(2)}|#{board.column(2).space(2)}|#{board.column(3).space(2)}|#{board.column(4).space(2)}|#{board.column(5).space(2)}|#{board.column(6).space(2)}|
      |#{board.column(0).space(1)}|#{board.column(1).space(1)}|#{board.column(2).space(1)}|#{board.column(3).space(1)}|#{board.column(4).space(1)}|#{board.column(5).space(1)}|#{board.column(6).space(1)}|
      |#{board.column(0).space(0)}|#{board.column(1).space(0)}|#{board.column(2).space(0)}|#{board.column(3).space(0)}|#{board.column(4).space(0)}|#{board.column(5).space(0)}|#{board.column(6).space(0)}|
      |0|1|2|3|4|5|6|
    EMPTY_TEMPLATE
  end
end
