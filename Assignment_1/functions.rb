require 'csv'

def read_csv (path, header = true, sep = "\t")
  
  my_csv = CSV.read(path, headers: header,  :col_sep => sep)
  
  return my_csv
end
