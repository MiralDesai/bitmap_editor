# frozen_string_literal: true

require './lib/image.rb'

class BitmapEditor
  def run(file)
    raise 'please provide correct file' if file.nil? || !File.exist?(file)
    start(file)
  end

  private

  def start(file)
    File.open(file).each do |line|
      raw_params = parse_line(line)
      params = sanitize_params(raw_params)
      command = params[0]
      case command
      when 'S'
        check_image_created(command)
        puts image.pretty_print
      when 'I'
        @image = Image.new(column: params[1], row: params[2])
      when 'L'
        check_image_created(command)
        image.set_colour_at(
          column: params[1],
          row: params[2],
          colour: params[3]
        )
      when 'V'
        check_image_created(command)
        image.paint_line(
          column: params[1],
          row_start: params[2],
          row_end: params[3],
          colour: params[4],
          direction: command
        )
      when 'H'
        check_image_created(command)
        image.paint_line(
          column: params[1],
          row_start: params[2],
          row_end: params[3],
          colour: params[4]
        )
      when 'C'
        check_image_created(command)
        image.clear
      else
        puts "Unrecognised command: #{params}"
      end
    end
  end

  def parse_line(line)
    line.chomp.split(' ')
  end

  # Could santize for each command here but seems a bit much for now (map.with_index etc)
  def sanitize_params(params)
    params.map do |param|
      raise 'Unknown parameter, please check file' unless param.match(/[a-z]/) || param.match(/[A-Z]/) || param.match(/\d{1,3}/)
      if param =~ /\d{1,3}/
        raise 'Coordinates must be between 1 and 250' unless param.to_i.between?(1, 250)
        param.to_i - 1
      elsif param =~ /[a-z]/
        param.upcase
      else
        param
      end
    end
  end

  def check_image_created(command)
    raise "Cannot perform #{command} without creating image first" unless image
  end

  attr_accessor :image
end
