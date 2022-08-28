# frozen_string_literal: true

class Board
  attr_reader :columns
  attr_accessor :previous_move

  def initialize(columns = Array.new(7) { Array.new(6) })
    @columns = columns
  end

  def drop(column, mark)
    bottom_index = columns[column].find_index(nil)
    if bottom_index.nil?
      nil
    else
      self.previous_move = [column, bottom_index]
      columns[column][bottom_index] = mark
    end
  end
end
