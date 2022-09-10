# frozen_string_literal: true

require_relative '../lib/game'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new }

  describe '#run_rounds' do
    context 'when #game_over is false once and then true' do
      subject(:one_round_game) { described_class.new }

      before do
        allow(one_round_game).to receive(:game_over?)
          .and_return(false, true)
      end

      it 'sends run_round once and stops' do
        expect(one_round_game).to receive(:run_round).once
        one_round_game.run_rounds
      end
    end

    context 'when #game_over is false three times and then true' do
      subject(:three_round_game) { described_class.new }

      before do
        allow(three_round_game).to receive(:game_over?)
          .and_return(false, false, false, true)
      end

      it 'sends run_round three times and stops' do
        expect(three_round_game).to receive(:run_round).exactly(3).times
        three_round_game.run_rounds
      end
    end
  end

  describe '#game_over?' do
    context 'when board receives any_wins? and returns false' do
      subject(:continue_game) { described_class.new(board: continue_board) }
      let(:continue_board) { instance_double(Board) }

      before do
        allow(continue_board).to receive(:any_wins?).and_return(false)
      end

      it 'returns true' do
        expect(continue_game.game_over?).to be(false)
      end
    end

    context 'when board receives any_wins? and returns true' do
      subject(:win_game) { described_class.new(board: win_board) }
      let(:win_board) { instance_double(Board) }
      before do
        allow(win_board).to receive(:any_wins?).and_return(true)
      end

      it 'returns true' do
        expect(win_game.game_over?).to be(true)
      end
    end
  end

  describe '#run_round' do
    subject(:game) do
      described_class.new(player1: player_x,
                          player2: player_o)
    end
    let(:player_x) { instance_double(Player, name: 'player_x', disc: 'x') }
    let(:player_o) { instance_double(Player, name: 'player_o', disc: 'o') }

    context 'when player_turn receives valid input' do
      let(:valid_input) { '2' }
      before :each do
        game.instance_variable_set(:@current_player, player_x)
        allow(game).to receive(:player_input).and_return(valid_input)
      end

      it 'sends #drop to board with valid choice and current_player.disc' do
        valid_choice = valid_input.to_i
        current_player_disc = game.current_player.disc

        expect(game.board).to receive(:drop)
          .with(valid_choice, current_player_disc).once
        game.run_round
      end
    end

    context 'when player_turn receives valid input' do
      let(:valid_input) { '4' }
      before :each do
        game.instance_variable_set(:@current_player, player_o)
        allow(game).to receive(:player_input).and_return(valid_input)
      end

      it 'sends #drop to board with valid choice and current_player.disc' do
        valid_choice = valid_input.to_i
        current_player_disc = game.current_player.disc

        expect(game.board).to receive(:drop)
          .with(valid_choice, current_player_disc).once
        game.run_round
      end
    end
  end

  describe '#current_player_choice' do
    subject(:new_game) { described_class.new }
    context 'when player_turn has not been called' do
      it 'returns nil' do
        expect(new_game.current_player_choice).to be(nil)
      end
    end

    context 'when player_turn receives valid input' do
      subject(:game_round) { described_class.new }
      let(:valid_input) { '3' }

      before do
        allow(game_round).to receive(:player_input)
          .and_return(valid_input)
        game_round.player_turn
      end

      it 'returns valid_input' do
        expect(game_round.current_player_choice).to eq(valid_input)
      end
    end

    context 'when player_turn receives invalid input and then valid input' do
      subject(:game_round) { described_class.new }
      let(:invalid_input) { 'woooow' }
      let(:valid_input) { '0' }

      before do
        allow(game_round).to receive(:player_input)
          .and_return(invalid_input, valid_input)
        game_round.player_turn
      end

      it 'returns valid_input' do
        expect(game_round.current_player_choice).to eq(valid_input)
      end
    end
  end

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

  describe '#choose_current_player' do
    context 'when current_player selected is player1' do
      it 'sets current_player to player1' do
        selected_player = game.player1
        expect { game.choose_current_player(selected_player) }
          .to change { game.current_player }.to(selected_player)
      end
    end

    context 'when current_player selected is player2' do
      it 'sets current_player to player2' do
        selected_player = game.player2
        expect { game.choose_current_player(selected_player) }
          .to change { game.current_player }.to(selected_player)
      end
    end
  end

  describe '#random_player' do
    context 'when called once with seed 1234' do
      before do
        srand(1234)
      end

      it 'returns player2' do
        expected_player = game.player2
        random_player = game.random_player
        expect(random_player).to be(expected_player)
      end
    end

    context 'when called three times with seed 1234' do
      before do
        srand(1234)
      end

      it 'returns player1' do
        expected_player = game.player1
        game.random_player
        game.random_player
        random_player = game.random_player
        expect(random_player).to be(expected_player)
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
