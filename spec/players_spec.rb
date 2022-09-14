# frozen_string_literal: true

require_relative '../lib/players'

# rubocop:disable Metrics/BlockLength

describe Players do
  subject(:players) { described_class.new }

  describe '#switch_current_player' do
    context 'when current_player is player1' do
      before do
        game.current_player = game.players[0]
      end

      xit 'sets current_player to player2' do
        expect { game.switch_current_player }.to change { game.current_player }
          .from(game.players[0]).to(game.players[1])
      end
    end

    context 'when current_player is player2' do
      before do
        game.current_player = game.players[1]
      end

      xit 'sets current_player to player1' do
        expect { game.switch_current_player }.to change { game.current_player }
          .from(game.players[1]).to(game.players[0])
      end
    end
  end

  describe '#random_player' do
    subject(:two_players) do
      described_class.new(player1: player_one, player2: player_two)
    end
    let(:player_one) { instance_double(Player, name: 'one', disc: '1') }
    let(:player_two) { instance_double(Player, name: 'two', disc: '2') }

    context 'when called once with seed 1234' do
      before do
        srand(1234)
      end

      it 'returns player2' do
        expected_player = player_two
        random_player = two_players.random_player

        expect(random_player).to eq(expected_player)
      end
    end

    context 'when called three times with seed 1234' do
      before do
        srand(1234)
      end

      it 'returns player1' do
        expected_player = player_one
        two_players.random_player
        two_players.random_player
        random_player = two_players.random_player

        expect(random_player).to be(expected_player)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
