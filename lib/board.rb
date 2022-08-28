# frozen_string_literal: true

class Board
  attr_reader :columns
  attr_accessor :previous_drop

  def initialize(columns = Array.new(7) { Array.new(6) })
    @columns = columns
  end

  # Am I using drop as both a noun and a verb?
  # Should they be separate?
  def drop(column, mark)
    bottom_index = columns[column].find_index(nil)
    if bottom_index.nil?
      nil
    else
      columns[column][bottom_index] = mark
      self.previous_drop = [column, bottom_index]
    end
  end

  def win?(disc)
    if diagonal?(disc)
      true
    # elsif vertical?(disc)
    # elsif horizontal?(disc)
    else
      false
    end
  end

  # Lots of wishful code.
  # Next diagonal is wishful
  # Coordinates are wishful
  # Combos might be wishful
  # I see linked lists but we can use arrays
  def diagonal?(disc)
    column_num = disc[0]
    index = disc[1]
    disc_mark = columns[column_num][index]

    combo_counter = 1

    loop do
      next_diagonal = disc.map { |coordinate| coordinate - 1 }
      next_diagonal_column_num = next_diagonal[0]
      next_diagonal_index = next_diagonal[1]
      next_diagonal_mark = columns[next_diagonal_column_num][next_diagonal_index]

      if next_diagonal_mark.nil?
        break
      elsif next_diagonal_mark == disc_mark
        combo_counter += 1
        disc = next_diagonal
      else
        break
      end
    end
    combo_counter >= 4
  end
end
