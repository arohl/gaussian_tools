#!/opt/local/bin/ruby -w

#open gaussian file
gauss_filename = ARGV.pop
gauss_file = File.new(gauss_filename, "r")

# skip to archive
while gauss_line = gauss_file.gets
	if gauss_line.include? "1\\1\\"
		break
	end	
end

# read until hit a blank line, adding all lines to a single string
archive = String.new(gauss_line)
while gauss_line = gauss_file.gets
	if gauss_line.strip.empty?
		break
	end	
	archive = archive.concat(gauss_line)
end
puts archive