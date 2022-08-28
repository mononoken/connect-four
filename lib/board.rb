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

  # def win?(disc)
  #   if diagonal_win?(disc)
  #     true
  #   # elsif vertical?(disc)
  #   # elsif horizontal?(disc)
  #   else
  #     false
  #   end
  # end

  # Lots of wishful code.
  # Next diagonal is wishful
  # Coordinates are wishful
  # Combos might be wishful
  # I see linked lists but we can use arrays
  def diagonal_win?(disc)
    disc_mark = mark(disc)

    combo_counter = 1
    loop do
      next_diagonal = disc.map { |coordinate| coordinate - 1 }
      next_diagonal_mark = mark(next_diagonal)

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

  def mark(coordinates)
    columns[coordinates[0]][coordinates[1]]
  end
end
