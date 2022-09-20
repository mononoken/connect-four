# frozen_string_literal: true

require_relative 'board_constants'

# Finds lines (an array of coordinates) for a given coordinate.
class BoardCoordinator
  include BoardConstants

  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
  end

  def column_num
    coordinates[0]
  end

  def row_num
    coordinates[1]
  end

  def horizontal(column_quantity = COL_QUANTITY)
    Array.new(column_quantity) { |index| [index, row_num] }
  end

  def vertical(row_quantity = ROW_QUANTITY)
    Array.new(row_quantity) { |index| [column_num, index] }
  end

  def left_diagonal
    left_diagonal = [coordinates]
    pointer = self
    loop do
      next_diagonal = BoardCoordinator.new([pointer.column_num - 1, pointer.row_num - 1])
      break if next_diagonal.off_board?

      left_diagonal.unshift(next_diagonal.coordinates)
      pointer = next_diagonal
    end

    pointer = self
    loop do
      next_diagonal = BoardCoordinator.new([pointer.column_num + 1, pointer.row_num + 1])
      break if next_diagonal.off_board?

      left_diagonal.push(next_diagonal.coordinates)
      pointer = next_diagonal
    end
    left_diagonal
  end

  def right_diagonal
    right_diagonal = [coordinates]
    pointer = self
    loop do
      next_diagonal = BoardCoordinator.new([pointer.column_num - 1, pointer.row_num + 1])
      break if next_diagonal.off_board?

      right_diagonal.unshift(next_diagonal.coordinates)
      pointer = next_diagonal
    end

    pointer = self
    loop do
      next_diagonal = BoardCoordinator.new([pointer.column_num + 1, pointer.row_num - 1])
      break if next_diagonal.off_board?

      right_diagonal.push(next_diagonal.coordinates)
      pointer = next_diagonal
    end
    right_diagonal
  end

  def off_board?
    column_num.negative? || column_num > COL_UPPER_INDEX || row_num.negative? || row_num > ROW_UPPER_INDEX
  end
end
