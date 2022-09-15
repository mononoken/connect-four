# frozen_string_literal:true

require_relative 'player'

# Represents the players in the Connect Four Game
class Players
  attr_reader :player1, :player2, :all
  attr_writer :order

  def initialize(player1:, player2:)
    @player1 = player1
    @player2 = player2
    @all = [player1, player2]
  end

  def run_round
    swap_current
  end

  def swap_current
    order.next
  end

  def current
    order.peek
  end

  def current=(player)
    self.order = [player, other_player(player)].cycle
  end

  def order(enumerator: random_order)
    @order ||= enumerator
  end

  def other_player(the_player)
    all.find { |player| player != the_player }
  end

  def random_player
    all[rand(all.count)]
  end

  private

  def random_order
    [random_player, other_player(random_player)].cycle
  end
end
