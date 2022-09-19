# frozen_string_literal: true

require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

describe Board do
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

  describe '#any_wins?' do
    context 'when drop is specified on a disc with no wins' do
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
        expect(continue_board.any_wins?(coordinates)).to be(false)
      end
    end

    context 'when drop is specfied on a disc with a win' do
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

      it 'returns false' do
        win_coordinates = [5, 3]
        expect(win_board.any_wins?(win_coordinates)).to be(true)
      end
    end

    context 'when drop was last called on not a winning move' do
      subject(:continue_board) { described_class.new(continue_template) }
      let(:continue_template) do
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
      let(:continue_move) { 1 }
      let(:continue_disc) { 'o' }

      before do
        continue_board.drop(continue_move, continue_disc)
      end

      it 'returns false' do
        expect(continue_board.any_wins?).to be(false)
      end
    end

    context 'when drop was last called on a winning move' do
      subject(:win_board) { described_class.new(win_template) }
      let(:win_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'x', 'x', nil, nil, nil],
          ['o', 'x', 'o', nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end
      let(:winning_move) { 5 }
      let(:winning_disc) { 'o' }

      before do
        win_board.drop(winning_move, winning_disc)
      end

      it 'returns true' do
        expect(win_board.any_wins?).to be(true)
      end
    end
  end

  describe '#lines_of_four' do
    subject(:board) { described_class.new }
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
