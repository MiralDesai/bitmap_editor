# frozen_string_literal: true

require 'spec_helper'
require './lib/bitmap_editor.rb'
require 'pry'

RSpec.describe BitmapEditor do
  context '#run' do
    it 'raises an error when no file is provided' do
      expect { described_class.new.run(nil) }.to raise_error(RuntimeError, 'please provide correct file')
    end
  end

  context '#check_image_created' do
    it 'raises an error when no image is created first' do
      expect { described_class.new.send(:check_image_created, 'C') }.to raise_error(RuntimeError)
    end
  end
end
