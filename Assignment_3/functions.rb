require 'csv'
require 'net/http'   # this is how you access the Web
require 'bio'

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
# @return response [File] the file body found at he addres.
def fetch(url)
  response = RestClient::Request.execute({
    method: :get,
    url: url.to_s})
  return response

end

# Access the embl and get the file given an gene code
# @param code [String] The gene code
# @return entry [Object] BIO::EMBL object
def fetch_embl(code, db = 'ensemblgenomesgene', format = 'embl')
  entry = Bio::Fetch::EBI.query(db, code, 'raw', format)
  return Bio::EMBL.new(entry)
end

# Given an array with strings, it transforms all af the elements to uppercase
# @param array [Array] The array with the strings
# @return array [Array] the same array with the uppercase elements.
def uppercase(array)
  for elem in array
    elem.upcase!
  end
  return array
end

# Given an EMBl entry, it extract the chormosome number, the start and end points of the enrty
# @param entry [Bio::EMBL] The entry from the Bio:.Embl object
# @return chromosone_number, entry_start, entry_end [Int]
def get_info_gene_entry(entry)
  chromosone_number, entry_start, entry_end = entry.accession.match(/.*:\w+\d+:(\d+):(\d+):(\d+)/).captures
  #chromosone_number = match[:chromosome]
  #entry_start = match[:start_chr].to_i
  #entry_end = match[:end_chr].to_i
  return chromosone_number, entry_start.to_i, entry_end.to_i
end