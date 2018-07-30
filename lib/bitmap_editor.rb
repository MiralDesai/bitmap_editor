require './lib/image.rb'
require 'pry'

class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)
    File.open(file).each do |line|
      whatever = parse_line(line)
      params = sanitize_params(whatever)
      command = params[0]
      case command
      when 'S'
        puts image.pretty_print
      when 'I'
        @image = Image.new(column: params[1], row: params[2])
      when 'L'
        # Cleanup params before passing to class?
        image.set_colour_at(column: params[1], row: params[2], colour: params[3])
      when 'V'
        # Set color for vertical line between coords
      when 'H'
        # Set color for horizontal line between coords
      when 'C'
        image.clear
      else
        puts "Unrecognised command: #{params}"
      end
    end
  end

  private

  def parse_line(line)
    params = line.chomp.split(' ')
  end

  # Could santize for each command here but seems a bit much for now (map.with_index etc)
  def sanitize_params(params)
    params.map do |param|
      raise 'Unknown parameter, please check file' unless param.match(/[a-z]/) || param.match(/[A-Z]/) || param.match(/\d{1,3}/)
      if param.match(/\d{1,3}/)
        raise 'Coordinates must be between 0 and 250' if !param.to_i.between?(0, 250)
        param.to_i
      elsif param.match(/[a-z]/)
        param.upcase
      else
        param
      end
    end
  end

  attr_accessor :image
end
