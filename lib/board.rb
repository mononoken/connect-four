# frozen_string_literal: true

require_relative 'board_constants'
require_relative 'board_coordinator'
require_relative 'board_visualizer'
require_relative 'column'

# Represents a 6x7 Connect Four board.
class Board
  include BoardConstants

  attr_reader :columns
  attr_accessor :last_disc

  def initialize(columns = Array.new(7) { Array.new(6) })
    @columns = columns.map.with_index do |array, index|
      Column.new(spaces: array, column_num: index)
    end
  end

  def run_round(column_num, disc)
    drop(column_num, disc)
    puts display
  end

  def last_disc_wins?
    disc_wins?(last_disc)
  end

  def disc_wins?(disc)
    return false if disc.nil?

    vertical_win?(disc) || horizontal_win?(disc) || diagonal_win?(disc)
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

  def lines_of_four(line)
    line.map.with_index do |_, index|
      line[index..index + 3] if line[index..index + 3].count == 4
    end.compact
  end

  def valid_drop?(column_num)
    valid_column?(column_num) && !column(column_num).full?
  end

  def drop(column_num, disc)
    self.last_disc = column(column_num).drop(disc)
  end

  def column(number)
    columns[number]
  end

  def full?
    columns.all?(&:full?)
  end

  def display
    BoardVisualizer.new(board: self).display
  end

  def four_in_a_row?(disc, direction)
    lines_of_four(direction).any? do |line_of_four|
      matching_marks?(line_values(line_of_four), mark(disc))
    end
  end

  def matching_marks?(marks, mark)
    return false if mark.nil?

    marks.all?(mark)
  end

  def line_values(line)
    line.map { |coordinate| mark(coordinate) }
  end

  def data
    columns.map(&:spaces).flatten
  end

  private

  def line(coordinates)
    BoardCoordinator.new(coordinates)
  end

  def mark(coordinates)
    column(coordinates[0]).space(coordinates[1])
  end

  def valid_column?(column_num)
    (COL_LOWER_INDEX..COL_UPPER_INDEX).include?(column_num)
  end
end
