require 'csv'



def read_csv (path, header = true, sep = "\t")

  my_csv = CSV.read(path, headers: header,  :col_sep => sep)
  
  return my_csv
end

def write_csv(path, data, sep = "\t", header)
  csv = CSV.open(path, "w", :write_headers=> true, :headers => header, :col_sep => sep)
  for row in data 
    csv << row
  end
end