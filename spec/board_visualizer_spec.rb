# frozen_string_literal: true

require_relative '../lib/board_visualizer'

# rubocop:disable Metrics/BlockLength

describe BoardVisualizer do
  describe '#display' do
    context 'when #board is empty' do
      subject(:empty_visualizer) do
        described_class.new(board: empty_board)
      end
      let(:empty_board) { Board.new }

      it 'returns empty display' do
        empty_display =
          <<~EMPTY_TEMPLATE
            || | | | | | | ||
            || | | | | | | ||
            || | | | | | | ||
            || | | | | | | ||
            || | | | | | | ||
            || | | | | | | ||
            ||0|1|2|3|4|5|6||
          EMPTY_TEMPLATE

        expect(empty_visualizer.display).to eq(empty_display)
      end
    end

    context 'when each board column has one x filled in' do
      subject(:bottom_x_visualizer) do
        described_class.new(board: bottom_x_board)
      end
      let(:bottom_x_board) { Board.new(bottom_x_columns) }
      let(:bottom_x_columns) { Array.new(7) { ['x', nil, nil, nil, nil, nil] } }

      it "returns display with x's at the bottom" do
        bottom_x_display =
          <<~BOTTOM_X_TEMPLATE
            || | | | | | | ||
            || | | | | | | ||
            || | | | | | | ||
            || | | | | | | ||
            || | | | | | | ||
            ||x|x|x|x|x|x|x||
            ||0|1|2|3|4|5|6||
          BOTTOM_X_TEMPLATE

        expect(bottom_x_visualizer.display).to eq(bottom_x_display)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
