# frozen_string_literal: true

require 'spec_helper'
require './lib/tile.rb'

RSpec.describe Tile do
  context 'when creating a tile without a value' do
    it 'the default value is used' do
      tile = Tile.new(row: 5, column: 5)
      expect(tile.value).to eq('O')
    end
  end
end
