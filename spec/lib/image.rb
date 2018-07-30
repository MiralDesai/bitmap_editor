# frozen_string_literal: true

require 'spec_helper'
require './lib/image.rb'

RSpec.describe Image do
  context 'when passing a row and a column' do
    it 'creates a new image' do
      image = described_class.new(column: 5, row: 8)
      expect(image).not_to be_nil
    end

    it 'and the tiles are created too' do
      image = described_class.new(column: 5, row: 8)
      expect(image.send(:tiles)).not_to be_nil
    end
  end

  context 'when clearing an image' do
    it 'the tiles values are set back to the default' do
      image = described_class.new(column: 10, row: 10)
      image.send(:tiles).first.first.value = 'A'
      expect(image.send(:tiles).first.first.value).to eq('A')
      image.clear
      expect(image.send(:tiles).first.first.value).to eq('O')
    end
  end

  context 'when painting a horizontal line' do
    it 'inclusively paints all tiles from start to end' do
      image = described_class.new(column: 10, row: 10)
      image.paint_line(column: 1, row_start: 1, row_end: 3, colour: 'B')
      painted_tile_one = image.send(:tiles)[1][1]
      painted_tile_two = image.send(:tiles)[1][2]
      painted_tile_three = image.send(:tiles)[1][3]
      expect(painted_tile_one.value).to eq('B')
      expect(painted_tile_two.value).to eq('B')
      expect(painted_tile_three.value).to eq('B')
    end
  end

  context 'when painting a horizontal line' do
    it 'inclusively paints all tiles from start to end' do
      image = described_class.new(column: 10, row: 10)
      image.paint_line(column: 1, row_start: 1, row_end: 3, colour: 'B', direction: 'V')
      painted_tile_one = image.send(:tiles)[1][1]
      painted_tile_two = image.send(:tiles)[2][1]
      painted_tile_three = image.send(:tiles)[3][1]
      expect(painted_tile_one.value).to eq('B')
      expect(painted_tile_two.value).to eq('B')
      expect(painted_tile_three.value).to eq('B')
    end
  end

  context 'when setting a colour' do
    it 'changes the tile value to the colour' do
      image = described_class.new(column: 10, row: 10)
      image.set_colour_at(column: 1, row: 1, colour: 'R')
      expect(image.send(:tiles)[1][1].value).to eq('R')
    end
  end

  context '#validate_row' do
    image = described_class.new(row: 1, column: 1)
    specify { expect(image.send(:validate_row, 1)).to be_nil }
  end

  context '#validate_column' do
    image = described_class.new(row: 5, column: 5)
    specify { expect(image.send(:validate_column, 4)).to be_nil }
  end

  context '#validate_position' do
    image = described_class.new(row: 5, column: 5)
    specify { expect(image.send(:validate_position, 1, 1)).to be_nil }
    image = described_class.new(row: 5, column: 5)
    specify { expect{ image.send(:validate_position, 10, 10) }.to raise_error(RuntimeError) }
  end

  context '#invalid_tile' do
    image = described_class.new(row: 5, column: 5)
    specify { expect(image.send(:invalid_tile?, 5, 5)).to be_truthy }
  end
end
