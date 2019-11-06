require './Interaction_Network.rb'


if ARGV.length != 1
  abort("Usage: ruby Interactor_searcher.rb  ArabidopsisSubNetwork_GeneList.txt")
end

begin
  puts "This may take a while..."
  Interaction_Network.search_for_interactors("./#{ARGV[0]}")
  Interaction_Network.write_report('./report.tsv')
  puts "\nFinal report can be found in ./report.tsv"
rescue
   # handles error
  abort("Something went wrong!\nUsage: ruby Interactor_searcher.rb  ArabidopsisSubNetwork_GeneList.txt")
end