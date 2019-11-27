
require './functions.rb'
require 'net/http'   # this is how you access the Web
require 'bio'

puts "Reading file"

my_codes = read_csv('./try_codes.txt', false, "\t").flatten!
target_sequence_forward = Bio::Sequence::NA.new("CTTCTT")
target_sequence_reverse = target_sequence_forward.complement

data_matched_exons = []
data_matched_ch = []
unmatched_codes_exons = []
unmatched_codes_gene = []

puts "Accessing EnsEMBL"
puts "Searching for target sequence 'CTTCTT' in exons genes..."
for code in my_codes

  entry = fetch_embl(code)
  gene_sequence = entry.to_biosequence
  chr_n, chr_start, chr_end =  get_info_gene_entry(entry)
  
  entry.features.each do |feature|
    next unless (feature.feature == "exon" && (not feature.position =~ /[A-Z]/))
    exons = feature.locations()  
    exons.each do |exon|
      exon_sequence = gene_sequence.splicing("#{exon.from}..#{exon.to}")
      if exon.strand == -1
        if exon_sequence.scan(/#{target_sequence_reverse.to_s}/i).each do |target_found|
            start_position = $~.offset(0).first
            end_position = $~.offset(0).last
            match_position_from = exon.from + start_position + 1
            match_position_to = exon.from + end_position + 1
            data_matched_exons << [code, "source", "target-CTTCTT", match_position_from, match_position_to,".", "-", ".", "gene_id:#{code}; transcript:complement(#{exon.from}..#{exon.to}); target: CTTCTT"]
          end
        else
          unmatched_codes_exons << code
        end
      else #exon is +
        if exon_sequence.scan(/#{target_sequence_forward.to_s}/i).each do |target_found|
            start_position = $~.offset(0).first
            end_position = $~.offset(0).last
            match_position_from = exon.from + start_position + 1
            match_position_to = exon.from + end_position + 1
            data_matched_exons << [code, "source", "target-CTTCTT", match_position_from, match_position_to,".", "+", ".", "gene_id:#{code}; transcript:#{exon.from}..#{exon.to}; target: CTTCTT"]
          end
        else
          unmatched_codes_exons << code
        end
      end
    end
  end
  
  if gene_sequence.scan(/#{target_sequence_forward.to_s}/i).each do |target_found|    
    start_position = $~.offset(0).first
    end_position = $~.offset(0).last
    match_position_from = chr_start + start_position + 1
    match_position_to = chr_end + end_position + 1
    data_matched_ch << [chr_n, "source", "target-CTTCTT", match_position_from, match_position_to,".", ".", ".", "gene_id:#{code}; target: CTTCTT"] 
  
    end
  else
    unmatched_codes_gene << code
  end
end   

write_csv("./target_found_exons.gff", data_matched_exons, "\t", "##gff-version 3")

puts "GFF file with target sequences found in the exons anc be found at './target_found_exons.gff'"

write_csv("./target_found_ch.gff", data_matched_ch, "\t", "##gff-version 3")

puts "GFF file with target sequences found in the exons anc be found at './target_found_ch.gff'"

write_csv("./unmatched_codes_exons.csv", unmatched_codes_exons, "\t", "unmatched_codes_exons")

puts "Unmatched genes './unmatched_codes_exons.csv'"

write_csv("./unmatched_codes_gene.csv", unmatched_codes_gene, "\t", "unmatched_codes_gene")

puts "Unmatched genes './unmatched_codes_gene.csv'"