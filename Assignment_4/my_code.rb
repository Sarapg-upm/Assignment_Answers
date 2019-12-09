
require './functions.rb'
require 'net/http'   # this is how you access the Web
require 'bio'
require 'stringio'

puts "Setting blast databases..."

db_protein = 'pep.fa'
db_nucleotides = 'TAIR10_seq_20110103_representative_gene_model_updated'
e_value = 0.0001
tair_factory, db_TAIR = set_blast_db('nucl','tblastn', db_nucleotides, 'db_tair', e_value)
pep_factory, db_pep = set_blast_db('prot','blastx', db_protein, 'db_pep', e_value)

puts "Opening multifasta queries..."

multifasta_queries = read_fasta('./TAIR10_seq_20110103_representative_gene_model_updated')
orthologs = []
puts "Searching for orthologs..."
multifasta_queries.each do |query|

  next unless first_hit = pep_factory.query(query.entry).hits.first
  fasta = db_pep.get_by_id(first_hit.hit_id)
  next unless report = tair_factory.query(fasta.seq)
  second_hit = report.hits.first
  coverage = (second_hit.query_end.to_f + 1 - second_hit.query_start.to_f)/report.query_len.to_f 
  puts coverage
  next unless query.definition == second_hit.definition and coverage >= 0.5
  gene = second_hit.target_def.match(/(?<code>\S+)/)
  protein = first_hit.target_def.match(/(?<code>[A-Za-z.0-9]+)/)
  orthologs << [gene, protein]
end

puts "Writting final report..."
write_csv("./orthologs_report.csv", orthologs, ["TAIR_DB","pep_DB"], ",")
puts "Report can be found in orthologs_report.csv"