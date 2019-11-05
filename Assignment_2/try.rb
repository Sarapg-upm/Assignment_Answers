require 'rest-client'   # this is how you access the Web
require './functions.rb'
require 'ruby-progressbar'
require 'json'


#my_codes = read_csv('./ArabidopsisSubNetwork_GeneList.txt', false, "\n").flatten!

my_codes = read_csv('./target-codes.tsv', false, "\n").flatten!

TAIR_code = Regexp.new(/AT\dG\d{0,5}/i)
interactors = Array.new

progressbar = ProgressBar.create(:total => my_codes.size)

uppercase(my_codes)
puts "Getting data...\n"

for code in my_codes

  tab25 = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code}?format=tab25"
  
  res = fetch(tab25)

  body = res.body  # get the "body" of the response
  all_codes = body.scan(TAIR_code)

  uppercase(all_codes)
  check_codes = all_codes & my_codes
  check_codes -= [code]
  if check_codes.any?
    interactors += check_codes
    interactors += [code]
  end
  
  progressbar.increment
  sleep 0.1

end

interactors.uniq!

for code in interactors
  kegg_gene = "http://togows.org/entry/kegg-genes/ath:#{code}.json"
  res = fetch(kegg_gene)
  data = JSON.parse(res.body)
  
  for elem in data[0]["pathways"].each
  #   puts elem
    puts "KEGG_Pathway ID: #{elem[0]}  name: #{elem[1]}"
  end
end