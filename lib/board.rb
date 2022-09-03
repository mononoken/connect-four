# frozen_string_literal: true

require 'board_coordinator'

# Represents a 6x7 Connect Four board.
class Board
  attr_reader :columns

  def initialize(columns = Array.new(7) { Array.new(6) })
    @columns = columns
  end

  def column(number)
    columns[number]
  end

  def drop(column_num, mark)
    return if column_full?(column_num)

    column(column_num)[first_nil(column_num)] = mark
  end

  def disc_wins?(disc, direction)
    lines_of_four(direction).any? do |line_of_four|
      matching_marks?(line_of_four, mark(disc))
    end
  end

  def diagonal_win?(disc)
    left_diagonal_win?(disc) || right_diagonal_win?(disc)
  end

  def left_diagonal_win?(disc)
    disc_wins?(disc, line(disc).left_diagonal)
  end

  def right_diagonal_win?(disc)
    disc_wins?(disc, line(disc).right_diagonal)
  end

  def horizontal_win?(disc)
    disc_wins?(disc, line(disc).horizontal)
  end

  def vertical_win?(disc)
    disc_wins?(disc, line(disc).vertical)
  end

  private

  def mark(coordinates)
    columns[coordinates[0]][coordinates[1]]
  end

  def first_nil(column_num)
    column(column_num).find_index(nil)
  end

  def column_full?(column_num)
    column(column_num).none?(nil)
  end

  def line(coordinates)
    BoardCoordinator.new(coordinates)
  end

  def matching_marks?(line, mark)
    return false if mark.nil?

    line.all? { |coordinates| mark(coordinates) == mark }
  end

  def lines_of_four(line)
    line.map.with_index do |_, index|
      line[index..index + 3] if line[index..index + 3].count == 4
    end.compact
  end
end
