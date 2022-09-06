# frozen_string_literal: true

require_relative '../lib/game'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new(board) }
  let(:board) { instance_double(Board) }

  describe '#valid_move?' do
    context 'when column choice is not full on board ' do
      before do
        allow(board).to receive(:column_full?).and_return(false)
      end

      it 'returns true' do
        column_choice = 0
        expect(game.valid_move?(column_choice)).to be(true)
      end
    end

    context 'when column choice is full on board' do
      before do
        allow(board).to receive(:column_full?).and_return(true)
      end

      it 'returns false' do
        column_choice = 3
        expect(game.valid_move?(column_choice)).to be(false)
      end
    end

    context 'when column choice does not exist on board' do
      before do
        
    end
  end

  describe '#game_over?' do
    context 'when board.any_wins? returns true to last move' do
      xit 'returns true' do
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
