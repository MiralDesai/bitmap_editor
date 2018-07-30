require './lib/image.rb'
require 'pry'

class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      params = parse_line(line)
      command = params[0]
      case command
      when 'S'
        puts image.pretty_print
      when 'I'
        @image = Image.new(column: params[1], row: params[2])
      when 'C'
        image.clear
      else
        puts "Unrecognised command: #{line}"
      end
    end
  end

  def parse_line(line)
    params = line.chomp.split(' ')
    # Validation here or for specific command?
  end

  attr_accessor :image
end
