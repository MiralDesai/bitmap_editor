# frozen_string_literal: true

class Tile
  def initialize(row:, column:, value: 'O')
    @row = row
    @column = column
    @value = value
  end

  attr_accessor :row, :column, :value
end
