# frozen_string_literal: true

require_relative '../lib/game'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new }

  describe '#verify_input' do
    context 'when player input is valid column 3' do
      it 'returns player input' do
        player_input = '3'
        verified_input = game.verify_input(player_input)
        expect(verified_input).to eq(player_input)
      end
    end

    context 'when player input is valid column 0' do
      it 'returns player input' do
        player_input = '0'
        verified_input = game.verify_input(player_input)
        expect(verified_input).to eq(player_input)
      end
    end

    context 'when player input is invalid 55' do
      it 'returns nil' do
        invalid_input = '55'
        verified_input = game.verify_input(invalid_input)
        expect(verified_input).to be(nil)
      end
    end

    context 'when player input is invalid string' do
      it 'returns nil' do
        invalid_input = 'wizard'
        verified_input = game.verify_input(invalid_input)
        expect(verified_input).to be(nil)
      end
    end
  end

  describe '#player_turn' do
    context 'when player input is valid on first loop' do
      before do
        allow(game).to receive(:verify_input)
          .and_return(true)
        allow(game).to receive(:puts)
      end

      it 'loops once' do
        expect(game).to receive(:verify_input).once
        game.player_turn
      end
    end

    context 'when player input is invalid once and then valid' do
      before do
        allow(game).to receive(:verify_input)
          .and_return(false, true)
        allow(game).to receive(:puts)
      end

      it 'loops twice' do
        expect(game).to receive(:verify_input).exactly(2).times
        game.player_turn
      end
    end

    context 'when player input is invalid 4 times and then valid' do
      before do
        allow(game).to receive(:verify_input)
          .and_return(false, false, false, false, true)
        allow(game).to receive(:puts)
      end

      it 'loops five times' do
        expect(game).to receive(:verify_input).exactly(5).times
        game.player_turn
      end
    end

    context 'when player input is invalid 4 times and then valid' do
      before do
        allow(game).to receive(:verify_input)
          .and_return(false, false, false, false, true)
        allow(game).to receive(:puts)
      end

      it 'sends invalid_input msg 4 times' do
        expect(game).to receive(:invalid_input).exactly(4).times
        game.player_turn
      end
    end
  end

  describe '#valid_input?' do
    context "when input is '0'" do
      it 'returns true' do
        valid_input = '0'
        expect(game.valid_input?(valid_input)).to be(true)
      end
    end

    context "when input is '6'" do
      it 'returns true' do
        valid_input = '6'
        expect(game.valid_input?(valid_input)).to be(true)
      end
    end

    context 'when input is invalid string' do
      it 'returns false' do
        invalid_input = 'bernard'
        expect(game.valid_input?(invalid_input)).to be(false)
      end
    end

    context 'when input is blank' do
      it 'returns false' do
        invalid_input = ''
        expect(game.valid_input?(invalid_input)).to be(false)
      end
    end

    context 'when input is 0 but an Integer' do
      it 'returns false' do
        invalid_input = 0
        expect(game.valid_input?(invalid_input)).to be(false)
      end
    end
  end

  describe '#switch_current_player' do
    context 'when current_player is player1' do
      before do
        game.current_player = game.player1
      end

      it 'sets current_player to player2' do
        expect { game.switch_current_player }.to change { game.current_player }
          .from(game.player1).to(game.player2)
      end
    end

    context 'when current_player is player2' do
      before do
        game.current_player = game.player2
      end

      it 'sets current_player to player1' do
        expect { game.switch_current_player }.to change { game.current_player }
          .from(game.player2).to(game.player1)
      end
    end
  end

  # describe '#run_round' do
  #   subject(:game) { described_class.new(board) }
  #   let(:board) { instance_double(Board) }
  #   context 'when drop is valid and drop returns [0, 3]' do
  #     let(:drop_coordinates) { [0, 3] }

  #     before do
  #       allow(game).to receive(:valid_input?).and_return(true)
  #       allow(board).to receive(:drop).and_return(drop_coordinates)
  #     end

  #     it 'pushes drop coordinates into drops' do
  #       expect { game.run_round }.to change { game.drops.last }
  #         .to(drop_coordinates)
  #     end
  #   end

  #   context 'when drop is valid and drop returns [3, 4]' do
  #     let(:drop_coordinates) { [3, 4] }

  #     before do
  #       allow(game).to receive(:valid_input?).and_return(true)
  #       allow(board).to receive(:drop).and_return(drop_coordinates)
  #     end

  #     it 'pushes drop coordinates into drops' do
  #       expect { game.run_round }.to change { game.drops.last }
  #         .to(drop_coordinates)
  #     end
  #   end

  #   context 'when drop is invalid once' do
  #     before do
  #       allow(game).to receive(:valid_input?).and_return(false)
  #     end

  #     it 'does not change drops' do
  #       expect { game.run_round }.not_to change { game.drops.last }
  #     end
  #   end
  # end
end

# rubocop:enable Metrics/BlockLength
