require './lib/tile.rb'

class Image
  def initialize(column:, row:)
    @column = column
    @row = row
    create
  end

  def pretty_print
    image = ''
    @column.times do |column|
      @row.times do |row|
        image << tiles[column][row].value
      end
      image << "\n"
    end
    image
  end

  def clear
    tiles.map do |columns|
      columns.map { |tile| tile.value = 'O' }
    end
  end

  def set_colour_at(column:, row:, colour:)
    tiles[column][row].value = colour
  end

  private

  def create
    @tiles = Array.new(column) { |column| Array.new(row) { |row| Tile.new(row: row, column: column) } }
  end

  attr_accessor :column, :row, :tiles
end
