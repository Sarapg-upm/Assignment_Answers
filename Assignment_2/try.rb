require 'rest-client'   # this is how you access the Web
require './functions.rb'
require 'ruby-progressbar'
require 'json'
require './AT_Gene.rb'


AT_Gene.insert_data('./target-codes.tsv')
AT_Gene.get_report('./report.tsv')

report = read_csv('./report.tsv')
for row in report
  print row
end
#for object in data
#  puts object.TAIR_ID
#  print object.get_data
#  puts
#end
#
##my_codes = read_csv('./ArabidopsisSubNetwork_GeneList.txt', false, "\n").flatten!
#
#my_codes = read_csv('./target-codes.tsv', false, "\n").flatten!
#
#TAIR_code = Regexp.new(/AT\dG\d{0,5}/i)
#interactors = Array.new
#
#progressbar = ProgressBar.create(:total => my_codes.size,
#                                 :format => '%t %a |%b|%i| %p%% ',
#                                 :progress_mark  => '=',
#                                 :remainder_mark => " ",
#                                 :title => "Getting Data ")
#
#uppercase(my_codes)
##puts "Getting data...\n"
#
#for code in my_codes
#
#  tab25 = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code}?format=tab25"
#  
#  res = fetch(tab25)
#
#  #body = res.body  # get the "body" of the response
#  all_codes = res.body.scan(TAIR_code)
#
#  uppercase(all_codes)
#  check_codes = all_codes & my_codes
#  check_codes -= [code]
#  
#  #check_codes.any? ? (interactors += check_codes) :
#  #interactors += check_codes unless check_codes.empty?
#  if check_codes.any?
#    interactors += check_codes
#    interactors += [code]
#  end
#  #
#  progressbar.increment
#  sleep 0.1
#
#end
#
#interactors.uniq!
#
#for code in interactors
#  kegg_gene = "http://togows.org/entry/kegg-genes/ath:#{code}.json"
#  GO_query = "http://togows.dbcls.jp/entry/uniprot/#{code}/dr.json" 
#  
#  res = fetch(kegg_gene)
#  data = JSON.parse(res.body)
#  
#  res2 = fetch(GO_query)
#  data_GO = JSON.parse(res2.body)
#  kegg_path, kegg_name = Array.new, Array.new
#  puts "\nThis code #{code}"
#  for elem in data[0]["pathways"]
#     #print elem
#     kegg_path <<  elem[0]
#     kegg_name << elem[1]
#    #puts "\tKEGG_Pathway ID: #{elem[0]}  name: #{elem[1]}"
#  end
#  print kegg_path
#  print kegg_name
#  #for go in data_GO[0]["GO"]
#  #  if (go[1]=~ /^P:/)
#  #    puts "GO_ID:#{go[0]}\tname: #{go[1]}"
#  #  end
#  #end
#end
