require './Interaction_Network.rb'
require './functions.rb'
require 'net/http'   # this is how you access the Web
require 'bio'  


my_codes = read_csv('./ArabidopsisSubNetwork_GeneList.txt', false, "\n").flatten!

weird_codes = Array.new
for code in my_codes
  
  address = URI("http://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ensemblgenomesgene&format=embl&id=#{code}")  # create a "URI" object (Uniform Resource Identifier: https://en.wikipedia.org/wiki/Uniform_Resource_Identifier)
  
  response = Net::HTTP.get_response(address)  # use the Net::HTTP object "get_response" method
                                               
  record = response.body
  
  entry = Bio::EMBL.new(record)
  puts entry.class
  puts "The record is #{entry.definition} "
  
  entry.features.each do |feature|
  
    position = feature.position
    #puts position
    #puts "\n\n\n\nPOSITION = #{position}"
    ft = feature.feature            # feature.assoc gives you a hash of Bio::Feature::Qualifier objects 
                                    # i.e. qualifier['key'] = value  for example qualifier['gene'] = "CYP450")
    #puts "Associations = #{qual}"
    # skips the entry if "/translation=" is not found
    #puts qual
    next unless (ft == "exon" && (position =~ /[A-Z]/))  # this is an indication that the feature is a transcript
    weird_codes += [code]
    # collects gene name and so on and joins it into a string
    #gene_info = [
    #  qual['gene'], qual['product'], qual['note'], qual['function']
    #].compact.join(', ')
    #puts "TRANSCRIPT FOUND!\nGene Info:  #{gene_info}"
    ## shows nucleic acid sequence
    #puts "\n\n>NA splicing('#{position}') : #{gene_info}"
    #puts entry.naseq.class   # this is a Bio::Sequence::NA    Look at the documentation to understand the .splicing() method
    #puts entry.naseq.splice(position)  # http://bioruby.org/rdoc/Bio/Sequence/Common.html#method-i-splice
    #
    ## shows amino acid sequence translated from nucleic acid sequence
    #puts "\n\n>AA translated by splicing('#{position}').translate"
    #puts entry.naseq.splicing(position).translate
    #
    ## shows amino acid sequence in the database entry (/translation=)
    #puts "\n\n>AA original translation"
    #puts qual['translation']
  end
  
    
  #puts "\n\nNumber of features #{entry.features.length}"
end

puts weird_codes.uniq