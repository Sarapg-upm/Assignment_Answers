require 'csv'
require 'date'

def read_csv (path, header = true, sep = "\t")
  
  my_csv = CSV.read(path, headers: header,  :col_sep => sep)
  
  return my_csv
end

def write_csv(path, header, sep = "\t")
  my_csv = CSV.open (path)
end

def is_datetime(d)
  d.methods.include? :strftime
end

