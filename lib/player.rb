# frozen_string_literal: true

# Represents a player in the game
class Player
  attr_reader :name, :disc
  def initialize(name, disc)
    @name = name
    @disc = disc
  end
end
