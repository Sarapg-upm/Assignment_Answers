require 'rest-client'   # this is how you access the Web
require './functions.rb'
require 'ruby-progressbar'



#my_codes = read_csv('./ArabidopsisSubNetwork_GeneList.txt', false, "\n")

my_codes = read_csv('./test_codes.tsv', false, "\n")
my_codes.flatten!
progressbar = ProgressBar.create(:total => my_codes.size)
TAIR_code = Regexp.new(/AT\dG\d{0,5}/i)
#chloroplast = Regexp.new(/At\w\wx\d\d/i)
regex_positive = Regexp.new(/taxid:3702(arath)/i)
#regex_all_taxid = Regexp.new(/taxid:\d+(\w+)/)
#i = 1 d
n_of_ath_codes = Array.new
positive_control = Array.new
total_hits = Array.new
#total_taxid = Array.new 
#puts "Getting data from the Web\n"
for code in my_codes
  
  #puts i
  tab25 = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code}?format=tab25"
  count = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code}?format=count"

  res = fetch(tab25)
  res2 = fetch(count)
  #puts res2.body
  total_hits << res2.body.to_i

  body = res.body  # get the "body" of the response
  #puts body.scan(TAIR_code)
  n_of_ath_codes << body.scan(TAIR_code).flatten.uniq
  positive_control << body.scan(regex_positive)
  #puts body.scan(regex_positive)
  #puts body.scan(regex_all_taxid)
  #total_taxid << body.scan(regex_all_taxid)
  #i += 1
  progressbar.increment
  sleep 0.1
end

#puts total_hits.inject(0){|sum,x| sum + x }
#total_taxid_real =  total_taxid.length/2
#puts total_taxid_real
#puts n_of_ath_codes.length array.map(&:upcase)
my_uppercas = Array.new()
for i in n_of_ath_codes.flatten
  #for j in i
    my_uppercas << i.upcase
  #end
end
my_uppercas = my_uppercas.uniq

#puts unique_array
#puts "IM LOKKING AND THIS ONE"
#puts unique_array.length

#puts positive_control.length
#i = 0
#for j in my_uppercas
#  puts j
#end

write_csv("./results2.csv", my_uppercas, "ATGENES") 
puts my_uppercas.length
#http://togows.org/entry/kegg-genes/ath:AT3G11945.json

#address = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/AT2g13360?format=tab25"
#
#res = fetch(address)

#puts res.scan(meshcode)
#data = read_csv('./results.csv', false, "\n")
#sum = 0
#for row in data
#  sum += row[0].to_i
#end
#puts 
#puts sum