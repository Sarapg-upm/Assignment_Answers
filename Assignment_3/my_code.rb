require './Interaction_Network.rb'
require './functions.rb'
require 'net/http'   # this is how you access the Web
require 'bio'
require 'enumerator'


my_codes = read_csv('./try_codes.txt', false, "\t").flatten!
target_sequence_string = "CTTCTT"
target_sequence = Regexp.new(target_sequence_string, Regexp::IGNORECASE)
for code in my_codes

  entry = fetch_embl(code)
  gene_sequence = entry.to_biosequence
  puts get_info_gene_entry(entry)
  entry.features.each do |feature|
    next unless (feature.feature == "exon" && (not feature.position =~ /[A-Z]/))
    exon = gene_sequence.splicing(feature.position) 
    next unless exon.scan(target_sequence).each do |target_found|
      start_position, end_position = $~.offset(0) #$~ : The MatchData of the last Regexp match in the current scope.
      exon_locations = feature.locations()
      exon_locations.each do |loc|
        puts "range = #{loc.from}..#{loc.to} (strand = #{loc.strand})"
      end
    end
  end
end
