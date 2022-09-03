# frozen_string_literal: true

# Represent a player in Connect Four
class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end
