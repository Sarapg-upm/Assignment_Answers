require './Interaction_Network.rb'
require './functions.rb'
require 'net/http'   # this is how you access the Web
require 'bio'
require 'enumerator'

#https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ensemblgenomesgene&id=AT5g54270&format=embl

my_codes = read_csv('./try_codes.txt', false, "\t").flatten!
#my_codes_string = my_codes.join(",")
#print my_codes_string
target_sequence_forward = Bio::Sequence::NA.new("CTTCTT")
target_sequence_reverse = target_sequence_forward.complement

for code in my_codes

  entry = fetch_embl(code)
  gene_sequence = entry.to_biosequence
  chr_n, chr_start, chr_end =  get_info_gene_entry(entry)
  
  entry.features.each do |feature|
    next unless (feature.feature == "exon" && (not feature.position =~ /[A-Z]/))
    
    #next unless exon.scan(target_sequence).each do |target_found|
    #  start_position, end_position = $~.offset(0) #$~ : The MatchData of the last Regexp match in the current scope.
    #  exon_locations = feature.locations()
    #  exon_locations.each do |loc|
    #    puts "range = #{loc.from}..#{loc.to} (strand = #{loc.strand})"
    #  end
    #end
    
    exons = feature.locations()
    
    exons.each do |exon|
      if exon.strand == -1
        exon_sequence = gene_sequence.splicing("#{exon.from}..#{exon.to}")
        next unless exon_sequence.scan(/#{target_sequence_reverse.to_s}/i).each do |target_found|
          puts target_found

          for matches in Regexp.last_match.offset(0)
            puts matches
          end
          #start_position, end_position = $~.offset(0) #$~ : The MatchData of the last Regexp match in the current scope.
        #  puts "exn sequence\n #{exon_sequence}"  
        #  puts "STAR POSITION #{start_position}"
        #  puts "END POSITION #{end_position}"
        end
      end
    end
    
    #puts gene_sequence.output(:fasta)
    #
    #exon = gene_sequence.splicing(feature.position) #  If position of feature doesn't fit with gene sequence length, next feature
    #
    #puts exon
    #
    #exon_in_gene = feature.locations() # Bio::Locations object (container for Bio::Location objects)
    #
    #exon.scan(target_sequence) do |repetition| # Search motif in the exon sequence
    #  from=$~.offset(0).first
    #  to=$~.offset(0).last
    #  
    #  if exon_in_gene.first.strand == -1 # Depending on strand sign, get coordinates
    #    length = to - from # Length of motif
    #    to = exon_in_gene.first.to - from + 1 # Where repetition ends in gene
    #    from = to - length + 1 # Where repetition starts in gene
    #    new_coord_chr = "#{from + chr_start - 2}..#{to + chr_start - 2 }" # Get coordinates in chromosome
    #    new_coord_gene="#{from - 1}..#{to - 1}" # Get coordinates in gene
    #    puts gene_sequence.splicing(new_coord_gene)
    #  end
    #end
    
  end
end
