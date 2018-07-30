# frozen_string_literal: true

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
        image = image.dup << tiles[column][row].value
      end
      image = image.dup << "\n"
    end
    image = image.dup << "\n"
    image
  end

  def clear
    tiles.map do |columns|
      columns.map { |tile| tile.value = 'O' }
    end
  end

  def set_colour_at(column:, row:, colour:)
    validate_position(column, row)
    tiles[column][row].value = colour
  end

  def paint_line(column:, row_start:, row_end:, colour:, direction: 'H')
    case direction
    when 'H'
      validate_row(row_start)
      validate_row(row_end)
      validate_column(column)
      (row_start..row_end).each do |current_row|
        tiles[column][current_row].value = colour
      end
    else
      validate_column(row_start)
      validate_column(row_end)
      validate_row(column)
      (row_start..row_end).each do |current_row|
        tiles[current_row][column].value = colour
      end
    end
  end

  private

  def validate_row(row)
    raise "Invalid row: #{row}" unless row.between?(1, @row)
  end

  def validate_column(column)
    raise "Invalid column: #{column}" unless column.between?(1, @column)
  end

  def validate_position(column, row)
    raise "Invalid selection for column: #{column} and row: #{row}" if invalid_tile?(column, row)
  end

  def invalid_tile?(column, row)
    tiles.dig(column, row).nil?
  end

  def create
    @tiles = Array.new(column) { |column| Array.new(row) { |row| Tile.new(column: column, row: row) } }
  end

  attr_accessor :column, :row, :tiles
end
