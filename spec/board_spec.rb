# frozen_string_literal: true

require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

describe Board do
  subject(:board) { described_class.new }

  describe '#diagonal_win?' do
    context 'when disc [4, 2] does not form a left diagonal win' do
      subject(:continue_board) { described_class.new(partial_template) }
      let(:partial_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'o', 'x', nil, nil, nil],
          ['x', 'o', 'o', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns false' do
        disc = [4, 2]
        expect(continue_board.diagonal_win?(disc)).to be(false)
      end
    end

    context 'when disc [4, 3] forms a diagonal win to the left' do
      subject(:win_board) { described_class.new(win_template) }
      let(:win_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'o', 'x', nil, nil, nil],
          ['x', 'o', 'o', 'x', nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns true' do
        disc = [4, 3]
        expect(win_board.diagonal_win?(disc)).to be(true)
      end
    end

    context 'when disc [5, 4] forms a diagonal win to the left' do
      subject(:win_board) { described_class.new(win_template) }
      let(:win_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'o', 'o', 'x', nil, nil],
          ['o', 'x', 'o', 'o', nil, nil],
          ['x', 'o', 'o', 'o', 'x', nil],
          ['x', 'o', 'x', 'x', 'o', nil],
          ['x', nil, nil, nil, nil, nil]
        ]
      end

      it 'returns true' do
        disc = [5, 4]
        expect(win_board.diagonal_win?(disc)).to be(true)
      end
    end

    context 'when disc [2, 1] does not form a right diagonal win' do
      subject(:continue_board) { described_class.new(partial_template) }
      let(:partial_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'o', 'x', nil, nil, nil],
          ['x', 'o', 'o', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns false' do
        disc = [2, 1]
        expect(continue_board.diagonal_win?(disc)).to be(false)
      end
    end

    context 'when disc [1, 3] forms a diagonal win to the right' do
      subject(:win_board) { described_class.new(win_template) }
      let(:win_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', 'o', nil, nil],
          ['x', 'x', 'o', nil, nil, nil],
          ['o', 'o', 'x', nil, nil, nil],
          ['o', 'o', 'x', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns true' do
        disc = [1, 3]
        expect(win_board.diagonal_win?(disc)).to be(true)
      end
    end
  end

  describe '#horizontal_win?' do
    context 'when disc [3, 2] does not form a horizontal win' do
      subject(:continue_board) { described_class.new(partial_template) }
      let(:partial_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'o', 'x', nil, nil, nil],
          ['x', 'o', 'o', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns false' do
        disc = [3, 2]
        expect(continue_board.horizontal_win?(disc)).to be(false)
      end
    end

    context 'when disc [5, 0] forms a horizontal win' do
      subject(:win_board) { described_class.new(win_template) }
      let(:win_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'x', 'o', nil, nil, nil],
          ['o', nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns true' do
        disc = [5, 0]
        expect(win_board.horizontal_win?(disc)).to be(true)
      end
    end
  end

  describe '#vertical_win?' do
    context 'when disc [3, 2] does not form a horizontal win' do
      subject(:continue_board) { described_class.new(partial_template) }
      let(:partial_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'o', 'x', nil, nil, nil],
          ['x', 'o', 'o', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns false' do
        disc = [3, 2]
        expect(continue_board.vertical_win?(disc)).to be(false)
      end
    end

    context 'when disc [2, 4] forms a horizontal win' do
      subject(:win_board) { described_class.new(win_template) }
      let(:win_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', 'x', 'x', nil],
          ['o', 'o', 'o', nil, nil, nil],
          ['o', 'x', 'o', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns true' do
        disc = [2, 4]
        expect(win_board.vertical_win?(disc)).to be(true)
      end
    end
  end

  describe '#valid_drop?' do
    subject(:board) { described_class.new }
    context 'when column_num is 0 and game is new' do
      it 'returns true' do
        column_num = 0
        expect(board.valid_drop?(column_num)).to be(true)
      end
    end

    context 'when column_num is 55 and game is new' do
      it 'returns false' do
        column_num = 55
        expect(board.valid_drop?(column_num)).to be(false)
      end
    end

    context 'when valid column_num is 3 and selected column is full' do
      subject(:filled_board) { described_class.new(columns) }
      let(:columns) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'o', 'x', 'o', 'x', 'x'],
          ['x', 'o', 'o', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns false' do
        column_num = 3
        expect(filled_board.valid_drop?(column_num)).to be(false)
      end
    end
  end

  describe '#disc_wins?' do
    context 'when specified disc does not form any wins' do
      subject(:continue_board) { described_class.new(partial_template) }
      let(:partial_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'o', 'x', nil, nil, nil],
          ['x', 'o', 'o', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns false' do
        coordinates = [2, 2]
        expect(continue_board.disc_wins?(coordinates)).to be(false)
      end
    end

    context 'when specified disc is nil' do
      subject(:continue_board) { described_class.new(partial_template) }
      let(:partial_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'o', 'x', nil, nil, nil],
          ['x', 'o', 'o', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns false' do
        coordinates = [5, 5]
        expect(continue_board.disc_wins?(coordinates)).to be(false)
      end
    end

    context 'when specified disc does form a win' do
      subject(:win_board) { described_class.new(win_template) }
      let(:win_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'o', 'x', nil, nil, nil],
          ['x', 'o', 'o', nil, nil, nil],
          ['o', 'x', 'x', 'o', nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'returns true' do
        win_coordinates = [5, 3]
        expect(win_board.disc_wins?(win_coordinates)).to be(true)
      end
    end
  end

  describe '#four_in_a_row?' do
    subject(:win_board) { described_class.new }
    context 'when selected row direction contains 4 matching discs in a row' do
      let(:winning_direction) { [[4, 0], [4, 1], [4, 2], [4, 3], [4, 4]] }
      let(:winning_disc) { [4, 2] }
      before do
        direction_values = ['x', 'x', 'x', 'x', nil]
        winning_direction.each_with_index do |coordinate, index|
          allow(win_board).to receive(:mark).with(coordinate)
                                            .and_return(direction_values[index])
        end
        allow(win_board).to receive(:mark).with(winning_disc)
                                          .and_return(direction_values[2])
      end

      it 'returns true' do
        result = win_board.four_in_a_row?(winning_disc, winning_direction)
        expect(result).to be(true)
      end
    end

    subject(:continue_board) { described_class.new }
    context 'when selected row direction contains 4 matching discs in a row' do
      let(:a_direction) { [[2, 2], [3, 2], [4, 2], [5, 2], [6, 2]] }
      let(:a_disc) { [4, 2] }
      before do
        direction_values = ['o', 'x', 'o', nil, nil]
        a_direction.each_with_index do |coordinate, index|
          allow(continue_board).to receive(:mark).with(coordinate)
                               .and_return(direction_values[index])
        end
        allow(continue_board).to receive(:mark).with(a_disc)
                             .and_return(direction_values[2])
      end

      it 'returns false' do
        result = continue_board.four_in_a_row?(a_disc, a_direction)
        expect(result).to be(false)
      end
    end

  end

  describe '#matching_marks?' do
    context 'when line array all have the same disc value' do
      it 'returns true' do
        marks = %w[x x x x x]
        mark = 'x'
        expect(board.matching_marks?(marks, mark)).to be(true)
      end
    end

    context 'when line array do not all have same disc value' do
      it 'returns false' do
        marks = %w[x o x o]
        mark = 'x'
        expect(board.matching_marks?(marks, mark)).to be(false)
      end
    end

    context 'when line array is all nil' do
      it 'returns false' do
        marks = [nil, nil, nil]
        mark = nil
        expect(board.matching_marks?(marks, mark)).to be(false)
      end
    end

    context 'when line array are all the same but do not match selected mark' do
      it 'returns false' do
        marks = %w[o o o]
        mark = 'x'
        expect(board.matching_marks?(marks, mark)).to be(false)
      end
    end
  end

  describe '#line_values' do
    context 'when given line returns nils to #mark' do
      let(:line_of_nils) { [[0, 0], [1, 0], [2, 0], [3, 0]] }
      before do
        line_of_nils.each do |coordinate|
          allow(board).to receive(:mark).with(coordinate)
                                        .and_return(nil)
        end
      end

      it 'returns an array of nils' do
        array_of_nils = [nil, nil, nil, nil]
        expect(board.line_values(line_of_nils)).to eq(array_of_nils)
      end
    end

    context 'when given line returns 1, 2, and 3 to #mark' do
      let(:line_of_ints) { [[0, 0], [1, 0], [2, 0]] }
      before do
        mark_values = [1, 2, 3]
        line_of_ints.each_with_index do |coordinate, index|
          allow(board).to receive(:mark).with(coordinate)
                                        .and_return(mark_values[index])
        end
      end

      it 'returns an array of the integers' do
        array_of_ints = [1, 2, 3]
        expect(board.line_values(line_of_ints)).to eq(array_of_ints)
      end
    end
  end

  describe '#lines_of_four' do
    context 'when given an array of unique values' do
      let(:unique_values) { %w[a b c d e f g] }
      it 'returns an array of every instance of 4 items in the OG array' do
        all_arrays_of_four = [
          %w[a b c d],
          %w[b c d e],
          %w[c d e f],
          %w[d e f g]
        ]
        expect(board.lines_of_four(unique_values))
          .to eq(all_arrays_of_four)
      end
    end

    context 'when given an array of line values' do
      let(:line) { ['o', 'o', 'x', 'o', nil, nil, nil] }
      it 'returns an array of every instance of 4 items in the OG array' do
        all_lines_of_four = [
          ['o', 'o', 'x', 'o'],
          ['o', 'x', 'o', nil],
          ['x', 'o', nil, nil],
          ['o', nil, nil, nil]
        ]
        expect(board.lines_of_four(line))
          .to eq(all_lines_of_four)
      end
    end
  end

  describe '#drop' do
    context 'when sent with column choice 5 on a new board' do
      subject(:new_board) { described_class.new }
      let(:column_choice) { 2 }
      let(:disc) { 'x' }

      it 'sets self.last_disc to drop coordinates' do
        drop_coordinates = new_board.drop(column_choice, disc)
        expect(new_board.last_disc).to eq(drop_coordinates)
      end
    end

    context 'when sent with column choice 3 on active board' do
      subject(:active_board) { described_class.new(active_template) }
      let(:active_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['x', 'x', 'o', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end
      let(:column_choice) { 1 }
      let(:disc) { 'o' }

      it 'sets self.last_disc to drop coordinates' do
        drop_coordinates = active_board.drop(column_choice, disc)
        expect(active_board.last_disc).to eq(drop_coordinates)
      end
    end
  end

  describe '#full?' do
    context 'when all columns are full' do
      subject(:full_board) { described_class.new(full_template) }
      let(:full_template) { Array.new(7) { Array.new(6) { 'x' } } }

      it 'returns true' do
        expect(full_board.full?).to be(true)
      end
    end

    context 'when all columns are empty' do
      subject(:empty_board) { described_class.new }

      it 'returns false' do
        expect(empty_board.full?).to be(false)
      end
    end

    context 'when columns are partially full' do
      subject(:partial_board) { described_class.new(partial_template) }
      let(:partial_template) { Array.new(7) { ['x', 'o', nil, nil, nil, nil] } }

      it 'returns false' do
        expect(partial_board.full?).to be(false)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
