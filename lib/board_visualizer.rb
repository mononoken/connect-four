# frozen_string_literal: true

require_relative 'board'
require_relative 'board_constants'

# Visual display of Board for Connect Four.
class BoardVisualizer
  include BoardConstants

  attr_reader :board

  def initialize(board:)
    @board = board
  end

  def column_numbers
    (LOWER_INPUT..UPPER_INPUT).to_a
  end

  def converted_data(data = board.data)
    data.map { |disc| disc.nil? ? ' ' : disc }
  end

  def display(data = converted_data, labels = column_numbers)
    <<~TEMPLATE
      ||#{data[5]}|#{data[11]}|#{data[17]}|#{data[23]}|#{data[29]}|#{data[35]}|#{data[41]}||
      ||#{data[4]}|#{data[10]}|#{data[16]}|#{data[22]}|#{data[28]}|#{data[34]}|#{data[40]}||
      ||#{data[3]}|#{data[9]}|#{data[15]}|#{data[21]}|#{data[27]}|#{data[33]}|#{data[39]}||
      ||#{data[2]}|#{data[8]}|#{data[14]}|#{data[20]}|#{data[26]}|#{data[32]}|#{data[38]}||
      ||#{data[1]}|#{data[7]}|#{data[13]}|#{data[19]}|#{data[25]}|#{data[31]}|#{data[37]}||
      ||#{data[0]}|#{data[6]}|#{data[12]}|#{data[18]}|#{data[24]}|#{data[30]}|#{data[36]}||
      ||#{labels[0]}|#{labels[1]}|#{labels[2]}|#{labels[3]}|#{labels[4]}|#{labels[5]}|#{labels[6]}||
    TEMPLATE
  end
end
