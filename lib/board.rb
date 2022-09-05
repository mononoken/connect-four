# frozen_string_literal: true

require 'board_coordinator'
require 'column'

# Represents a 6x7 Connect Four board.
class Board
  attr_reader :columns

  def initialize(columns = Array.new(7) { Array.new(6) })
    @columns = columns.map { |array| Column.new(array) }
  end

  def column(number)
    columns[number]
  end

  def four_in_a_row?(disc, direction)
    lines_of_four(direction).any? do |line_of_four|
      matching_marks?(line_of_four, mark(disc))
    end
  end

  def diagonal_win?(disc)
    left_diagonal_win?(disc) || right_diagonal_win?(disc)
  end

  def left_diagonal_win?(disc)
    four_in_a_row?(disc, line(disc).left_diagonal)
  end

  def right_diagonal_win?(disc)
    four_in_a_row?(disc, line(disc).right_diagonal)
  end

  def horizontal_win?(disc)
    four_in_a_row?(disc, line(disc).horizontal)
  end

  def vertical_win?(disc)
    four_in_a_row?(disc, line(disc).vertical)
  end

  def any_wins?(disc)
    vertical_win?(disc) || horizontal_win?(disc) || diagonal_win?(disc)
  end

  def last_drop
    [0, 0]
  end

  def game_over?
    true
  end

  private

  def line(coordinates)
    BoardCoordinator.new(coordinates)
  end

  def mark(coordinates)
    column(coordinates[0]).space(coordinates[1])
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
