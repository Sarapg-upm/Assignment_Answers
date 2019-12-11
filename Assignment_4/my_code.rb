
require 'bio'
require './functions.rb'
require 'csv'

# initial parameters
db_nucleotides = "TAIR10_seq_20110103_representative_gene_model_updated"
db_protein = "pep.fa"
e_value = "1e-6" 
thershold = 0.5

puts "Setting blast databases..."

#generating TAIR10 database
system("makeblastdb -in #{db_nucleotides} -dbtype 'nucl' -hash_index -out folder_nt/db_nt")
fastacmd1 = Bio::Blast::Fastacmd.new("folder_nt/db_nt")
factory1 = Bio::Blast.local('tblastn', "folder_nt/db_nt", "-e #{e_value}")
#generating pep database
system("makeblastdb -in #{db_protein} -dbtype 'prot' -hash_index -out folder_aa/db_aa")
factory2 = Bio::Blast.local('blastx', "folder_aa/db_aa", "-e #{e_value}")

puts <<END

The search of these orthologs are set under the parameters of the paper citted bellow.

The e-value was set at 1e-6 and a coverage of at least 50% of any of the sequences in the alignments.
--------------------------------------------------------------------------------
CITATION
Gabriel Moreno-Hagelsieb, Kristen Latimer,
Choosing BLAST options for better detection of orthologs as reciprocal best hits,
Bioinformatics, Volume 24, Issue 3, 1 February 2008, Pages 319–324,
https://doi.org/10.1093/bioinformatics/btm585
--------------------------------------------------------------------------------
END
puts "\nSearching for orthologs (this may take a while)..."

orthologs = [] #array for saving hte orthologs pairs 
multifasta = read_fasta('./pep.fa') #multifasta with the pep queries
multifasta.each do |entry|
  begin
  report1 = factory1.query(">#{entry.entry_id}\n#{entry.seq}") #searching for homologs in tair
  first_hit = report1.hits.first #best hit
  if get_coverage(first_hit,report1) >= thershold #if the coverage of the homolog reagion is greater than 0.5
  fastacmd1.fetch(first_hit.hit_id).each do |fasta| #search for the sequence in tair database
    begin
      report2 = factory2.query(">\n#{fasta.seq}") #searcho for homolog in pep
      second_hit = report2.hits.first #best hit
       if get_coverage(second_hit,report2) >= thershold and entry.definition == second_hit.definition # if coverage greater than 0.5 and reciprocal best hit
        match_gene = first_hit.definition.match(/(?<gene_code>\S+)/) #get tair code
        match_protein = entry.definition.match(/(?<protein_code>[A-Za-z.0-9]+)/) #get pep code
        orthologs << [match_gene[:gene_code], match_protein[:protein_code]] #saving orthologs
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
write_csv("./my_final_report.csv", orthologs, ["TAIR_DB","pep_DB"], ",") #writing the final report
puts "Report can be found in 'my_final_report.csv'"