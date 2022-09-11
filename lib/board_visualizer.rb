# frozen_string_literal: true

require_relative 'board'

# Visual display of Board for Connect Four.
class BoardVisualizer
  attr_reader :board

  def initialize(board:)
    @board = board
  end

  def converted_data(data = board.data)
    data.map { |disc| disc.nil? ? ' ' : disc }
  end

  def display
    <<~TEMPLATE
      ||#{converted_data[5]}|#{converted_data[11]}|#{converted_data[17]}|#{converted_data[23]}|#{converted_data[29]}|#{converted_data[35]}|#{converted_data[41]}||
      ||#{converted_data[4]}|#{converted_data[10]}|#{converted_data[16]}|#{converted_data[22]}|#{converted_data[28]}|#{converted_data[34]}|#{converted_data[40]}||
      ||#{converted_data[3]}|#{converted_data[9]}|#{converted_data[15]}|#{converted_data[21]}|#{converted_data[27]}|#{converted_data[33]}|#{converted_data[39]}||
      ||#{converted_data[2]}|#{converted_data[8]}|#{converted_data[14]}|#{converted_data[20]}|#{converted_data[26]}|#{converted_data[32]}|#{converted_data[38]}||
      ||#{converted_data[1]}|#{converted_data[7]}|#{converted_data[13]}|#{converted_data[19]}|#{converted_data[25]}|#{converted_data[31]}|#{converted_data[37]}||
      ||#{converted_data[0]}|#{converted_data[6]}|#{converted_data[12]}|#{converted_data[18]}|#{converted_data[24]}|#{converted_data[30]}|#{converted_data[36]}||
      ||0|1|2|3|4|5|6||
    TEMPLATE
  end
end
