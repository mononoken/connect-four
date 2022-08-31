# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength(RuboCop)
# rubocop:disable Metrics/MethodLength(RuboCop)

class Board
  attr_reader :columns
  attr_accessor :previous_drop

  def initialize(columns = Array.new(7) { Array.new(6) })
    @columns = columns
  end

  def column(number)
    columns[number]
  end

  def row(number)
    columns.map { |column| column[number] }
  end

  def first_nil(column_num)
    column(column_num).find_index(nil)
  end

  def column_full?(column_num)
    column(column_num).none?(nil)
  end

  def drop(column_num, mark)
    return if column_full?(column_num)

    column(column_num)[first_nil(column_num)] = mark
  end

  def matching_marks?(group, mark)
    group.all? { |coordinates| mark(coordinates) == mark }
  end

  def lines_of_four(line)
    line.map.with_index do |_, index|
      line[index..index + 3] if line[index..index + 3].count == 4
    end.compact
  end

  def disc_wins?(disc, direction)
    lines_of_four(direction).any? do |line_of_four|
      matching_marks?(line_of_four, mark(disc))
    end
  end

  def diagonal_win?(disc, diagonal)
    disc_wins?(disc, diagonal)
  end

  def horizontal_win?(disc, horizontal)
    disc_wins?(disc, horizontal)
  end

  def left_diagonal(coordinates)
    left_diagonal = [coordinates]
    pointer = coordinates
    loop do
      next_diagonal = [pointer[0] - 1, pointer[1] - 1]
      break if off_board?(next_diagonal)

      left_diagonal.unshift(next_diagonal)
      pointer = next_diagonal
    end

    pointer = coordinates
    loop do
      next_diagonal = [pointer[0] + 1, pointer[1] + 1]
      break if off_board?(next_diagonal)

      left_diagonal.push(next_diagonal)
      pointer = next_diagonal
    end
    left_diagonal
  end

  def right_diagonal(coordinates)
    right_diagonal = [coordinates]
    pointer = coordinates
    loop do
      next_diagonal = [pointer[0] - 1, pointer[1] + 1]
      break if off_board?(next_diagonal)

      right_diagonal.unshift(next_diagonal)
      pointer = next_diagonal
    end

    pointer = coordinates
    loop do
      next_diagonal = [pointer[0] + 1, pointer[1] - 1]
      break if off_board?(next_diagonal)

      right_diagonal.push(next_diagonal)
      pointer = next_diagonal
    end
    right_diagonal
  end

  def horizontal(coordinates)
    height = coordinates[1]
    [[0, height], [1, height], [2, height], [3, height], [4, height], [5, height], [6, height]]
  end

  def vertical(coordinates)
    row = coordinates[0]
    [[row, 0], [row, 1], [row, 2], [row, 3], [row, 4], [row, 5]]
  end

  def off_board?(coordinates)
    coordinates[0] < 0 || coordinates[0] > 6 || coordinates[1] < 0 || coordinates[1] > 5
  end

  def mark(coordinates)
    columns[coordinates[0]][coordinates[1]]
  end
end

# rubocop:enable Metrics/ClassLength(RuboCop)
# rubocop:enable Metrics/MethodLength(RuboCop)
