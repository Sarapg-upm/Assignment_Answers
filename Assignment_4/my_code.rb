
require 'bio'
require './functions.rb'
require 'net/http'   # this is how you access the Web
require 'stringio'
require 'csv'


db_nucleotides = "TAIR10_seq_20110103_representative_gene_model_updated"
db_protein = "pep.fa"
e_value = "1e-6"
thershold = 0.5

puts "Setting blast databases..."

system("makeblastdb -in #{db_nucleotides} -dbtype 'nucl' -hash_index -out folder_nt/db_nt")
fastacmd1 = Bio::Blast::Fastacmd.new("folder_nt/db_nt")
factory1 = Bio::Blast.local('tblastn', "folder_nt/db_nt", "-e #{e_value}")

system("makeblastdb -in #{db_protein} -dbtype 'prot' -hash_index -out folder_aa/db_aa")
factory2 = Bio::Blast.local('blastx', "folder_aa/db_aa", "-e #{e_value}")

puts "\nSearching for orthologs (this may take a while)..."

orthologs = []
multifasta = read_fasta('./pep.fa')
multifasta.each do |entry|
  begin
  report1 = factory1.query(">#{entry.entry_id}\n#{entry.seq}")
  first_hit = report1.hits.first 
  if get_coverage(first_hit,report1) >= thershold
  fastacmd1.fetch(first_hit.hit_id).each do |fasta|
    begin
      report2 = factory2.query(">\n#{fasta.seq}")
      second_hit = report2.hits.first
       if get_coverage(second_hit,report2) >= thershold and entry.definition == second_hit.definition 
        match_gene = first_hit.definition.match(/(?<gene_code>\S+)/)     
        match_protein = entry.definition.match(/(?<protein_code>[A-Za-z.0-9]+)/)
        orthologs << [match_gene[:gene_code], match_protein[:protein_code]]
       end
    rescue
      next
    end
  end
  end
  rescue
    next
  end
end

puts "Writting final report..."
write_csv("./my_final_report.csv", orthologs, ["TAIR_DB","pep_DB"], ",")
puts "Report can be found in 'my_final_report.csv'"