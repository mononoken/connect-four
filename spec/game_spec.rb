# frozen_string_literal: true

require_relative '../lib/game'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new(board) }
  let(:board) { instance_double(Board) }
  describe '#game_over?' do
    context 'when board.any_wins? returns false' do
      before do
        allow(board).to receive(:any_wins?).and_return(false)
      end

      xit 'returns false' do
        last_move = [4, 2]
        expect(game.game_over?).to be(false)
        board.any_wins?(last_move)
      end
    end

    context 'when board.any_wins? returns true' do
      before do
        allow(board).to receive(:any_wins?).and_return(true)
      end

      xit 'returns true' do
        last_move = [4, 2]
        expect(game.game_over?).to be(true)
        board.any_wins?(last_move)
      end
    end
  end

  describe '#play' do
    context 'when #run_round?' do
      xit 'blanks' do
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
