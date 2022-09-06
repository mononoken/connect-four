# frozen_string_literal: true

# Represents a column on a Connect Four board.
class Column
  attr_reader :spaces

  def initialize(spaces = Array.new(6))
    @spaces = spaces
  end

  def drop(disc)
    return if column_full?

    spaces[first_nil_index] = disc
  end

  def space(index)
    spaces[index]
  end

  def column_full?
    spaces.none?(nil)
  end

  private

  def first_nil_index
    spaces.find_index(nil)
  end
end
