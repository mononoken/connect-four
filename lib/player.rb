# frozen_string_literal: true

# Represent a player in Connect Four
class Player
  attr_reader :name, :disc

  def initialize(name:, disc:)
    @name = name
    @disc = disc
  end
end
