#!/opt/local/bin/ruby -w

require "matrix.rb"

class Atom
  def initialize(number, z, coord)
    @number = number
    @z   = z
    @coord = coord
  end
  
  attr_reader :number, :z, :coord
  
  def to_s
    "Atom: #{@number} - #{@z} - #{@coord}"
  end
end

elements = {"1" => "H", "6" => "C", "7" => "N", "8" => "O"}

#open gaussian file
# loop through gaussian files
ARGV.each do |gauss_filename|

	gauss_file = File.new(gauss_filename, "r")

	while gauss_line = gauss_file.gets
		# skip to coordinates
		if gauss_line.include? "Input orientation:"
			# skip next five lines
			1.upto(5) do
				gauss_line = gauss_file.gets
			end
			# read in coordinates
			coords = Array.new
			while !gauss_line.include? "------"
				tokens = gauss_line.split
				coord = Vector[tokens[3].to_f, tokens[4].to_f, tokens[5].to_f]
				coords.push Atom.new(tokens[0], tokens[1], coord)
				gauss_line = gauss_file.gets
			end
		elsif gauss_line.include? "Optimization completed"
			puts coords.count
			puts "gaussian scan"
			coords.each do |atom|
				print "%s %s %s %s\n" % [elements[atom.z], atom.coord[0], atom.coord[1], atom.coord[2]]
			end
		end
	end
end
