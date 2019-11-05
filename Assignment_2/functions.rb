require 'csv'


# Reads a csv file given a specific `path`
# @param path [String] The path in which the file can be found.  
# @param header [Boolean] If the csv has or not header. Boolean varaible set to `true` by default. 
# @param sep [String] separation of the columns.  It's "\t" by deafault
# @return [Array] An array of columns (also as arrays).
def read_csv(path, header = true, sep = "\t")
  my_csv = CSV.read(path, headers: header,  :col_sep => sep)
  
  return my_csv
end

# Similar to #read_csv() . Writes a csv file given a specific `path`.
# If there is an existan file in the current folder, the file will be overwritten.
# @param path [String] The path in which the file can be found.
# @param data [Array] Data to be written.
# @param header [Array] An array with the header. Every position in the array is the name of the column.
# @param sep [String] separation of the columns.  It's "\t" by deafault.
def write_csv(path, data, sep = "\t", header)
  csv = CSV.open(path, "w", :write_headers=> true, :headers => header, :col_sep => sep)
  for row in data 
    csv << row
  end
end

# Access the Web and get the file given an addres
# @param url [String] The address in which the file can be found at the Web.
# @return response.body [File] the file body found at he addres.
# @return false [Boolean] if there file response.body was not found.
def fetch(url)
  response = RestClient::Request.execute({
    method: :get,
    url: url.to_s})
  return response

end

def mesh=(code)
  meshcode = Regexp.new(/AT\dG\d{0,5}/i)
  if meshcode.match(code)
    @mesh = code
  else
    puts "This is not a valid mesh code - settting to 000000"
    @mesh = "0000000"
  end
end

def uppercase(array)
  for i in array
    i.upcase!
  end
  return array
end