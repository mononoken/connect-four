# frozen_string_literal: true

require_relative '../lib/game'

# rubocop:disable Metrics/BlockLength

describe Game do
  describe '#board' do
    context 'when board is empty' do
      subject(:new_game) { described_class.new }
      it 'returns an empty display' do
        empty_board =
          "| | | | | | | |\n" \
          "| | | | | | | |\n" \
          "| | | | | | | |\n" \
          "| | | | | | | |\n" \
          "| | | | | | | |\n" \
          "| | | | | | | |"
        expect(new_game.board).to eq(empty_board)
      end
    end

    context 'when board is partially filled' do
      subject(:partial_game) { described_class.new }
      it 'returns a display of previous moves' do
        partial_board =
          "| | | | | | | |\n" \
          "| | | | | | | |\n" \
          "| | | | | | | |\n" \
          "| | | | | | | |\n" \
          "| | | | | | | |\n" \
          "| |x|o|o|x| | |"
        expect(partial_game.board).to eq(partial_board)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
