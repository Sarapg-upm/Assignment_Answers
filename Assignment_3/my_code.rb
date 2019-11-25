require './Interaction_Network.rb'
require './functions.rb'
require 'net/http'   # this is how you access the Web
require 'bio'
require 'enumerator'


my_codes = read_csv('./try_codes.txt', false, "\t").flatten!
target_sequence_string = "CTTCTT"
target_sequence = Regexp.new(target_sequence_string, Regexp::IGNORECASE)
puts target_sequence
weird_codes = Array.new
for code in my_codes

  entry = fetch_embl(code)
  puts code
  #puts entry.accession
  gene_sequence = entry.to_biosequence
  #puts gene_sequence
  #puts entry.accession
  puts get_info_gene_entry(entry)
  entry.features.each do |feature|

    #position = feature.position
    #puts position
    #puts "\n\n\n\nPOSITION = #{position}"
    #ft = feature.feature            # feature.assoc gives you a hash of Bio::Feature::Qualifier objects 
                                    # i.e. qualifier['key'] = value  for example qualifier['gene'] = "CYP450")
    #puts "Associations = #{qual}"
    # skips the entry if "/translation=" is not found
    #puts qual
    next unless (feature.feature == "exon" && (not feature.position =~ /[A-Z]/))  # this is an indication that the feature is a transcript
    #print feature.qualifiers
    feature.qualifiers.each{|q| (/exon_id=(.+)/.match(q.value)) ? ex_id=$1: ex_id = nil}
    #puts ex_id
    #next if ex_id.nil? || /[A-Z]/.match(feature.position) # We are only interested in exons from gene (not remote entries)
    exon = gene_sequence.splicing(feature.position) #  If position of feature doesn't fit with gene sequence length, next feature
    
    #s = "AustinTexasDallasTexas"
    next unless exon.scan(target_sequence).each do |target_found|
          print $~.offset(0) #$~ : The MatchData of the last Regexp match in the current scope.
    end
    #positions = exon.enum_for(:scan, target_sequence).map { Regexp.last_match.begin(0) }
    #print positions
    #exon_in_gene = feature.locations()
    #print exon_in_gene.range()
    #puts
    #print exon_in_gene.first.strand
    #puts
    #print exon_in_gene.size
    #puts
    #puts exon
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

puts "LASTA"
exon = "AAAAAAAACTTCTTAAAAAC"
positions = exon.enum_for(:scan, target_sequence).map { Regexp.last_match.begin(0) }
print positions
puts target_sequence_string.to_s.length
print exon[positions[0], target_sequence_string.to_s.length]