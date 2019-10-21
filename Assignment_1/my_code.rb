require './Gene.rb'
require './Seed_stock.rb'
require './Hybrid_cross.rb'
require './functions.rb'



genes2 = Gene.insert_data("./gene_information.tsv")
puts genes2[1].gene_ID,genes2[1].name,genes2[1].mutant_phenotype

genes2 = Seed_stock.insert_data("./seed_stock_data.tsv")
puts genes2[1].mutant_gene_ID,genes2[1].seed_stock,genes2[1].last_planted

genes2 = Hybrid_cross.insert_data("./cross_data.tsv")
puts genes2[1].parent1,genes2[1].parent2,genes2[1].F2_wild

puts "Total genes"
puts Gene.total_genes

puts "Total stocks"
puts Seed_stock.total_stocks

