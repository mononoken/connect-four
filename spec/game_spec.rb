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

  describe '#winner?' do
    context 'when board receives any_wins? and returns false' do
      subject(:continue_game) { described_class.new(board: continue_board) }
      let(:continue_board) { instance_double(Board) }

      before do
        allow(continue_board).to receive(:any_wins?).and_return(false)
      end

      it 'returns true' do
        expect(continue_game.winner?).to be(false)
      end
    end

    context 'when board receives any_wins? and returns true' do
      subject(:win_game) { described_class.new(board: win_board) }
      let(:win_board) { instance_double(Board) }
      before do
        allow(win_board).to receive(:any_wins?).and_return(true)
      end

      it 'returns true' do
        expect(win_game.winner?).to be(true)
      end
    end
  end

  # describe '#run_round' do
  #   subject(:game) do
  #     described_class.new(player1: player_x,
  #                         player2: player_o)
  #   end
  #   let(:player_x) { instance_double(Player, name: 'player_x', disc: 'x') }
  #   let(:player_o) { instance_double(Player, name: 'player_o', disc: 'o') }

  #   context 'when player_turn receives valid input' do
  #     let(:valid_input) { '2' }
  #     before :each do
  #       game.instance_variable_set(:@current_player, player_x)
  #       allow(game).to receive(:player_input).and_return(valid_input)
  #     end

  #     it 'sends #drop to board with valid choice and current_player.disc' do
  #       valid_choice = game.to_index(valid_input)
  #       current_player_disc = game.current_player.disc

  #       expect(game.board).to receive(:drop)
  #         .with(valid_choice, current_player_disc).once
  #       game.run_round
  #     end
  #   end

  #   context 'when player_turn receives valid input' do
  #     let(:valid_input) { '4' }
  #     before :each do
  #       game.instance_variable_set(:@current_player, player_o)
  #       allow(game).to receive(:player_input).and_return(valid_input)
  #     end

  #     it 'sends #drop to board with valid choice and current_player.disc' do
  #       valid_choice = game.to_index(valid_input)
  #       current_player_disc = game.current_player.disc

  #       expect(game.board).to receive(:drop)
  #         .with(valid_choice, current_player_disc).once
  #       game.run_round
  #     end
  #   end
  # end

  describe 'draw?' do
    context 'when board is not full' do
      subject(:incomplete_game) { described_class.new(board: incomplete_board) }
      let(:incomplete_board) { instance_double(Board) }

      before do
        allow(incomplete_board).to receive(:full?).and_return(false)
      end

      it 'return false' do
        expect(incomplete_game.draw?).to be(false)
      end
    end

    context 'when board is full and there is no winner' do
      subject(:full_game) { described_class.new(board: full_board) }
      let(:full_board) { instance_double(Board) }

      before do
        allow(full_board).to receive(:full?).and_return(true)
        allow(full_game).to receive(:winner).and_return(nil)
      end

      it 'returns true' do
        expect(full_game.draw?).to be(true)
      end
    end

    context 'when board is full and there is a winner' do
      subject(:won_game) { described_class.new(board: won_board) }
      let(:won_board) { instance_double(Board) }
      let(:winner) { instance_double(Player) }

      before do
        allow(won_board).to receive(:full?).and_return(true)
        allow(won_game).to receive(:winner).and_return(winner)
      end

      it 'returns false' do
        expect(won_game.draw?).to be(false)
      end
    end
  end

  describe '#winner' do
    context 'when winner? is false' do
      subject(:new_game) { described_class.new }

      before do
        allow(new_game).to receive(:winner?).and_return(false)
      end

      it 'returns nil' do
        expect(new_game.winner).to be(nil)
      end
    end

    context 'when winner? is true' do
      subject(:won_game) do
        described_class.new(player1: player1, player2: player2)
      end
      let(:player1) { instance_double(Player, name: 'player1', disc: 'o') }
      let(:player2) { instance_double(Player, name: 'player2', disc: 'x') }

      before do
        allow(won_game).to receive(:winner?).and_return(true)
        won_game.instance_variable_set(:@current_player, player1)
      end

      it 'returns value of current_player' do
        expect(won_game.winner).to eq(won_game.current_player)
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
      let(:valid_input) { '1' }

      before do
        allow(game_round).to receive(:player_input)
          .and_return(invalid_input, valid_input)
        allow(game_round).to receive(:puts)
        game_round.player_turn
      end

      it 'returns valid_input' do
        expect(game_round.current_player_choice).to eq(valid_input)
      end
    end
  end

  describe '#verify_input' do
    context 'when receiving true from valid_input?' do
      let(:player_input) { '3' }
      before do
        allow(game).to receive(:valid_input?).with(player_input)
                                             .and_return(true)
      end

      it 'returns player input' do
        verified_input = game.verify_input(player_input)
        expect(verified_input).to eq(player_input)
      end
    end

    context 'when receiving false from valid_input? ' do
      let(:invalid_input) { '55' }
      before do
        allow(game).to receive(:valid_input?).with(invalid_input)
                                             .and_return(false)
      end

      it 'returns nil' do
        verified_input = game.verify_input(invalid_input)
        expect(verified_input).to be(nil)
      end
    end
  end

  describe '#valid_input?' do
    context 'when input is within LOWER_INPUT' do
      it 'returns true' do
        stub_const('Game::LOWER_INPUT', '0')
        valid_input = '0'
        expect(game.valid_input?(valid_input))
          .to be(true)
      end
    end

    context 'when input is within UPPER_INPUT' do
      it 'returns true' do
        stub_const('Game::UPPER_INPUT', '9000')
        valid_input = '8000'
        expect(game.valid_input?(valid_input))
          .to be(true)
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

  describe '#player_turn' do
    let(:current_player) { instance_double(Player, name: 'dummy', disc: 'z') }

    before :each do
      game.instance_variable_set(:@current_player, current_player)
    end

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
end

# rubocop:enable Metrics/BlockLength
