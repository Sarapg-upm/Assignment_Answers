require 'csv'
require 'date'
require 'fileutils'
include FileUtils

def read_csv (path, header = true, sep = "\t")
  
  
  my_csv = CSV.read(path, headers: header,  :col_sep => sep)
  
  return my_csv
end

def write_csv(path, row, sep = "\t", header)
  
  if CSV.read(path)
    rm %w(path)
  end
  csv = CSV.open(path, "a+", :write_headers=> true, :headers => header, :col_sep => sep)
  csv << row
end

def is_datetime(d)
  d.methods.include? :strftime
end

