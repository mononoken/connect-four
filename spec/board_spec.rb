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
  end
end

# rubocop:enable Metrics/BlockLength
