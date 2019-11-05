require 'rest-client'   # this is how you access the Web
require './functions.rb'
require 'ruby-progressbar'



#my_codes = read_csv('./ArabidopsisSubNetwork_GeneList.txt', false, "\n").flatten!

my_codes = read_csv('./test_codes.tsv', false, "\n").flatten!

progressbar = ProgressBar.create(:total => my_codes.size)
TAIR_code = Regexp.new(/AT\dG\d{0,5}/i)
regex_positive = Regexp.new(/taxid:3702\(arath\)/i)
fucking_ensemble = Regexp.new(/ensemblgenomes:AT\dG\d{0,5}/i)
total_hits = Array.new
n_of_ath_codes = Array.new
positive_control = Array.new
elensemble = Array.new
for code in my_codes

  tab25 = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code}?format=tab25"
  count = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code}?format=count"
  
  res = fetch(tab25)
  res2 = fetch(count)
  total_hits << res2.body.to_i

  body = res.body  # get the "body" of the response

  n_of_ath_codes += body.scan(TAIR_code)
  positive_control += body.scan(regex_positive)
  elensemble += body.scan(fucking_ensemble)
  progressbar.increment
  sleep 0.1
end

i = 0
for j in total_hits
  i += j
end
puts i


puts n_of_ath_codes.length
puts positive_control.length
puts elensemble.length


if (positive_control.length + elensemble.length) == n_of_ath_codes.length
  puts "SUCCEEEEESSSS!!!"
  puts positive_control.length
end