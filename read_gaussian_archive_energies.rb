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
while gauss_line = gauss_file.gets.strip
  if gauss_line.empty?
    break
  end
  archive = archive << gauss_line
end

# split on \ and search for HF line
archive.split("\\").each do |field|
  if field.include? "HF"
    # now have HF line can split on "=" to get energies as second element of array and
    # then split this on a ","
    energies = field.split("=")[1].split(",")
    energies.each do |energy|
      puts energy
    end
  end
end