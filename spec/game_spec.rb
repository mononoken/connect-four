# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#display' do
    context 'when board is empty' do
      it 'returns an empty display' do
        empty_board =
          '| | | | | | | |' \
          '| | | | | | | |' \
          '| | | | | | | |' \
          '| | | | | | | |' \
          '| | | | | | | |' \
          '| | | | | | | |'
        expect(new_game.display).to eq(empty_board)
      end
    end
  end
end
