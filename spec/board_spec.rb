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

  describe 'valid_drop?' do
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
end

# rubocop:enable Metrics/BlockLength
