# frozen_string_literal: true

# Represents a column on a Connect Four board.
class Column
  attr_reader :spaces, :number

  def initialize(spaces: Array.new(6), column_num: nil)
    @spaces = spaces
    @number = column_num
  end

  def drop(disc)
    return if full?

    dropped_index = first_nil_index
    spaces[first_nil_index] = disc
    [number, dropped_index]
  end

  def full?
    spaces.none?(nil)
  end

  def space(index)
    spaces[index]
  end

  private

  def first_nil_index
    spaces.find_index(nil)
  end
end
