require './lib/tile.rb'

class Image
  def initialize(column:, row:)
    @column = column.to_i
    @row = row.to_i
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

  private

  def create
    @tiles = Array.new(column) { |column| Array.new(row) { |row| Tile.new(row: row, column: column) } }
  end

  attr_accessor :column, :row, :tiles
end
