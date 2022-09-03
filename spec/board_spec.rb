# frozen_string_literal: true

require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

describe Board do
  describe '#drop(column, mark)' do
    context 'when column is empty' do
      subject(:new_board) { described_class.new }
      it 'changes first value of the column to the mark' do
        one_template = [
          [nil, nil, nil, nil, nil, nil],
          ['x', nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
        expect { new_board.drop(1, 'x') }
          .to change { new_board.columns }
          .to(one_template)
      end
    end

    context 'when column already has some marks' do
      subject(:partial_board) { described_class.new(partial_template) }
      let(:partial_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', nil, nil, nil, nil],
          ['o', nil, nil, nil, nil, nil],
          ['x', nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end
      it 'changes the next nil value of the column to the mark' do
        filled_template = [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', nil, nil, nil],
          ['o', 'x', 'o', nil, nil, nil],
          ['o', nil, nil, nil, nil, nil],
          ['x', nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
        expect { partial_board.drop(2, 'o') }
          .to change { partial_board.columns }
          .to(filled_template)
      end
    end

    context 'when column is already full' do
      subject(:full_board) { described_class.new(full_template) }
      let(:full_template) do
        [
          ['o', 'o', 'x', 'o', 'o', 'o'],
          ['x', 'o', 'x', 'o', 'x', 'x'],
          ['o', 'x', 'o', 'o', 'o', 'x'],
          ['o', 'x', 'o', 'x', 'x', 'o'],
          ['x', 'x', 'x', 'o', 'o', 'x'],
          ['o', 'o', 'x', 'x', 'o', 'o'],
          ['x', 'o', 'o', 'x', 'o', 'x']
        ]
      end
      it 'does not change column values' do
        expect { full_board.drop(4, 'x') }
          .not_to change { full_board.columns }
      end
    end
  end

  describe '#diagonal_win?(disc)' do
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

  describe '#horizontal_win?(disc)' do
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

  describe '#vertical_win?(disc)' do
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
end

describe BoardCoordinator do
  subject(:coordinator) { described_class.new(coordinates) }

  describe '#horizontal' do
    context 'when coordinates are [3, 3]' do
      let(:coordinates) { [3, 3] }
      it 'returns the horizontal containing [3, 3]' do
        horizontal_coordinates =
          [[0, 3], [1, 3], [2, 3], [3, 3], [4, 3], [5, 3], [6, 3]]
        expect(coordinator.horizontal).to eq(horizontal_coordinates)
      end
    end

    context 'when coordinates are [0, 0]' do
      let(:coordinates) { [0, 0] }
      it 'returns the horizontal containing [0, 0]' do
        horizontal_coordinates =
          [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0]]
        expect(coordinator.horizontal).to eq(horizontal_coordinates)
      end
    end
  end

  describe '#vertical' do
    context 'when coordinates are [3, 3]' do
      let(:coordinates) { [3, 3] }
      it 'returns the vertical containing [3, 3]' do
        vertical_coordinates =
          [[3, 0], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5]]
        expect(coordinator.vertical).to eq(vertical_coordinates)
      end
    end

    context 'when coordinates are [0, 0]' do
      let(:coordinates) { [0, 0] }
      it 'returns the vertical containing [0, 0]' do
        vertical_coordinates =
          [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5]]
        expect(coordinator.vertical).to eq(vertical_coordinates)
      end
    end
  end

  describe '#left_diagonal' do
    context 'when coordinates are [3, 3]' do
      let(:coordinates) { [3, 3] }
      it 'returns the left leaning diagonal containing [3, 3]' do
        left_leaning_diagonal =
          [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5]]
        expect(coordinator.left_diagonal).to eq(left_leaning_diagonal)
      end
    end

    context 'when coordinates are [0, 0]' do
      let(:coordinates) { [0, 0] }
      it 'returns the left leaning diagonal containing [0, 0]' do
        left_leaning_diagonal =
          [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5]]
        expect(coordinator.left_diagonal).to eq(left_leaning_diagonal)
      end
    end

    context 'when coordinates are [1, 4]' do
      let(:coordinates) { [1, 4] }
      it 'returns the left leaning diagonal containing [1, 4]' do
        left_leaning_diagonal =
          [[0, 3], [1, 4], [2, 5]]
        expect(coordinator.left_diagonal).to eq(left_leaning_diagonal)
      end
    end
  end

  describe '#right_diagonal' do
    context 'when coordinates are [3, 3]' do
      let(:coordinates) { [3, 3] }
      it 'returns the right leaning diagonal containing [3, 3]' do
        right_leaning_diagonal =
          [[1, 5], [2, 4], [3, 3], [4, 2], [5, 1], [6, 0]]
        expect(coordinator.right_diagonal).to eq(right_leaning_diagonal)
      end
    end

    context 'when coordinates are [6, 0]' do
      let(:coordinates) { [6, 0] }
      it 'returns the right leaning diagonal containing [6, 0]' do
        right_leaning_diagonal =
          [[1, 5], [2, 4], [3, 3], [4, 2], [5, 1], [6, 0]]
        expect(coordinator.right_diagonal).to eq(right_leaning_diagonal)
      end
    end

    context 'when coordinates are [0, 0]' do
      let(:coordinates) { [0, 0] }
      it 'returns the right leaning diagonal containing [0, 0]' do
        right_leaning_diagonal =
          [[0, 0]]
        expect(coordinator.right_diagonal).to eq(right_leaning_diagonal)
      end
    end
  end

  describe '#off_board?' do
    context 'when coordinates are [0, 0]' do
      let(:coordinates) { [0, 0] }
      it 'returns false' do
        expect(coordinator.off_board?).to be(false)
      end
    end

    context 'when coordinates are [6, 5]' do
      let(:coordinates) { [6, 5] }
      it 'returns false' do
        expect(coordinator.off_board?).to be(false)
      end
    end

    context 'when coordinates are [-1, 5]' do
      let(:coordinates) { [-1, 5] }
      it 'returns true' do
        coordinates = [-1, 5]
        expect(coordinator.off_board?).to be(true)
      end
    end

    context 'when coordinates are [3, -1]' do
      let(:coordinates) { [3, -1] }
      it 'returns true' do
        expect(coordinator.off_board?).to be(true)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
