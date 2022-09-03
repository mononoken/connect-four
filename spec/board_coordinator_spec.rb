# frozen_string_literal: true

require_relative '../lib/board_coordinator'

# rubocop:disable Metrics/BlockLength

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
