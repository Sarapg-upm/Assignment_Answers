require 'rest-client'   # this is how you access the Web
require './functions.rb'
require 'ruby-progressbar'



my_codes = read_csv('./ArabidopsisSubNetwork_GeneList.txt', false, "\n").flatten!

#my_codes = read_csv('./test_codes.tsv', false, "\n").flatten!

#progressbar = ProgressBar.create(:total => my_codes.size)
TAIR_code = Regexp.new(/AT\dG\d{0,5}/i)
#regex_positive = Regexp.new(/taxid:3702\(arath\)/i)
total_hits = Array.new
#n_of_ath_codes = Array.new
#positive_control = Array.new
for code in my_codes
  code.upcase!
end

for code in my_codes

  tab25 = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code}?format=tab25"
  #count = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code}?format=count"
  
  res = fetch(tab25)
  #res2 = fetch(count)
  #total_hits << res2.body.to_i

  body = res.body  # get the "body" of the response
  all_codes = body.scan(TAIR_code)
  for l in all_codes
    l.upcase!
  end

  check_codes = all_codes & my_codes
  check_codes -= [code]
  puts "Original code:"
  puts code
  puts "Interactors:"
  print check_codes
  puts
  #n_of_ath_codes += body.scan(TAIR_code)
  #positive_control += body.scan(regex_positive)
  #
  #progressbar.increment
  #sleep 0.1

end

i = 0
for j in total_hits
  i += j
end
puts i


#puts n_of_ath_codes.length
new_total_hits = total_hits.reject {|x| x == 0 }
puts new_total_hits.length
