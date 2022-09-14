# frozen_string_literal: true

require_relative '../lib/players'

# rubocop:disable Metrics/BlockLength

describe Players do
  subject(:two_players) do
    described_class.new(player1: player_one, player2: player_two)
  end
  let(:player_one) { instance_double(Player, name: 'one', disc: '1') }
  let(:player_two) { instance_double(Player, name: 'two', disc: '2') }

  describe '#swap_current' do
    context 'when #current message is player_one' do
      before do
        two_players.current = player_one
      end

      it 'changes #current message to player_two' do
        expect { two_players.swap_current }.to change { two_players.current }
          .from(player_one).to(player_two)
      end
    end

    context 'when #current message is player_two' do
      before do
        two_players.current = player_two
      end

      it 'changes #current message to player_one' do
        expect { two_players.swap_current }.to change { two_players.current }
          .from(player_two).to(player_one)
      end
    end
  end

  describe '#current=' do
    context 'when passed player_one' do
      it 'sets @order to an enumerator starting with player_one' do
        two_players.current = player_one
        expect(two_players.order.peek).to eq(player_one)
      end
    end

    context 'when passed player_two' do
      it 'sets @order to an enumerator starting with player_two' do
        two_players.current = player_two
        expect(two_players.order.peek).to eq(player_two)
      end
    end
  end

  describe '#order' do
    context 'when @order is nil and given an enumerator' do
      let(:given_enumerator) { [].to_enum }
      before do
        two_players.instance_variable_set(:@order, nil)
      end

      it 'sets @order to the value of given enumerator' do
        two_players.order(enumerator: given_enumerator)
        expect(two_players.order).to eq(given_enumerator)
      end
    end

    context 'when @order is not nil' do
      let(:an_enumerator) { [].to_enum }
      before do
        two_players.instance_variable_set(:@order, an_enumerator)
      end

      it 'returns @order' do
        order_instance_variable = two_players.instance_variable_get(:@order)
        expect(two_players.order).to eq(order_instance_variable)
      end
    end
  end

  describe '#other_player' do
    context 'when passed player_one' do
      it 'returns player_two' do
        expect(two_players.other_player(player_one)).to be(player_two)
      end
    end

    context 'when passed player_two' do
      it 'returns player_one' do
        expect(two_players.other_player(player_two)).to be(player_one)
      end
    end
  end

  describe '#random_player' do
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
