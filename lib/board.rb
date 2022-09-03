# frozen_string_literal: true

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

# Finds lines for a given coordinate.
class BoardCoordinator
  COL_QUANTITY = 7
  ROW_QUANTITY = 6
  COL_UPPER_INDEX = COL_QUANTITY - 1
  ROW_UPPER_INDEX = ROW_QUANTITY - 1

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
