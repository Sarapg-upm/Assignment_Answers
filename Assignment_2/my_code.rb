require 'rest-client'   # this is how you access the Web
require './functions.rb'

my_codes = read_csv('./ArabidopsisSubNetwork_GeneList.txt', false, "\n")


for code in my_codes
  
  address = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code[0]}?format=count"
  res = fetch(address)
  if res
    body = res.body  # get the "body" of the response
    puts body
  end
end

#http://togows.org/entry/kegg-genes/ath:AT3G11945.json