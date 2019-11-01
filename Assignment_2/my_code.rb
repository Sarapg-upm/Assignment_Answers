require 'rest-client'   # this is how you access the Web
require './functions.rb'

my_codes = read_csv('./ArabidopsisSubNetwork_GeneList.txt', false, "\n")

TAIR_code = Regexp.new(/AT\dG\d{0,5}/i)
#chloroplast = Regexp.new(/At\w\wx\d\d/i)
regex_positive = Regexp.new(/taxid:3702(arath)/)
regex_all_taxid = Regexp.new(/taxid:\d+(\w+)/)
#i = 1 d
n_of_ath_codes = Array.new
positive_control = Array.new
total_hits = Array.new
total_taxid = Array.new
for code in my_codes
  
  #puts i
  address = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code[0]}?format=tab25"
  address2 = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code[0]}?format=count"

  res = fetch(address)
  res2 = fetch(address2)
  puts res2.body
  total_hits << res2.body.to_i

  body = res.body  # get the "body" of the response
  #puts body.scan(TAIR_code)
  n_of_ath_codes << body.scan(TAIR_code)
  positive_control << body.scan(regex_positive)
  puts body.scan(regex_positive)
  #puts body.scan(regex_all_taxid)
  total_taxid << body.scan(regex_all_taxid)
  #i += 1
end

puts total_hits.inject(0){|sum,x| sum + x }
total_taxid_real =  total_taxid.length/2
puts total_taxid_real
puts n_of_ath_codes.length
puts positive_control.length
#http://togows.org/entry/kegg-genes/ath:AT3G11945.json

#address = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/AT2g13360?format=tab25"
#
#res = fetch(address)

#puts res.scan(meshcode)
class InteractionNewtwork 

    attr_accessor :body  
    
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
      @body = parms.fetch(:body, "mybody")
    end
    
    def search(regex)
      My_regex = Regexp.new(regex)
      my_body = @body
      my_match = My_regex.match(my_body)
      return my_match
    end
end
data = read_csv('./results.csv', false, "\n")
sum = 0
for row in data
  sum += row[0].to_i
end
puts 
puts sum