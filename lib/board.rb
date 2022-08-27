# frozen_string_literal: true

class Board
  attr_reader :columns

  def initialize(columns = Array.new(7) { Array.new(6) })
    @columns = columns
  end

  def drop(column, mark)
    bottom_index = columns[column].find_index(nil)
    columns[column][bottom_index] = mark
  end
end
