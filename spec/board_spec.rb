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

  describe '#previous_drop' do
    context 'when no moves have been made' do
      subject(:new_board) { described_class.new }
      it 'returns nil' do
        expect(new_board.previous_drop).to be(nil)
      end
    end

    context "when last move was marking 'o' in empty column 3" do
      subject(:board) { described_class.new }

      before do
        board.drop(3, 'o')
      end

      it 'returns [3, 0]' do
        expect(board.previous_drop).to eq([3, 0])
      end
    end

    context 'when last move was attempted in full column' do
      subject(:full_column_board) { described_class.new(full_column_template) }
      let(:full_column_template) do
        [
          [nil, nil, nil, nil, nil, nil],
          ['x', 'o', 'x', 'o', 'x', 'o'],
          ['o', 'x', nil, nil, nil, nil],
          ['o', nil, nil, nil, nil, nil],
          ['x', nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'does not change value of previous_drop' do
        expect { full_column_board.drop(1, 'x') }
          .not_to change { full_column_board.previous_drop }
      end
    end
  end

  describe '#win?(disc)' do
    context 'when disc [4, 2] does not form a win' do
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
        expect(continue_board.win?([4, 2])).to be(false)
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
        expect(win_board.win?([4, 3])).to be(true)
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
        expect(win_board.win?([5, 4])).to be(true)
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
        expect(win_board.win?([1, 3])).to be(true)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
