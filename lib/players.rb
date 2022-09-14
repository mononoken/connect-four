# frozen_string_literal:true

require_relative 'player'

# Represents the players in the Connect Four Game
class Players
  attr_reader :player1, :player2, :all
  attr_writer :order
g
  def initialize(player1: Player.new(name: 'player1', disc: 'o'),
                 player2: Player.new(name: 'player2', disc: 'x'))
    @player1 = player1
    @player2 = player2
    @all = [player1, player2]
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

  ###

  def winner
    current_player if winner?
  end

  def player_turn
    loop do
      self.current_player_choice = verify_input(player_input)
      break if current_player_choice

      invalid_input
    end
  end

  # Move to Player?
  def player_input(player_name = current_player.name)
    puts "#{player_name}, choose a column between #{LOWER_INPUT} and #{UPPER_INPUT} to drop your disc."
    gets.chomp
  end

  private

  def random_order
    [random_player, other_player(random_player)].cycle
  end
end
