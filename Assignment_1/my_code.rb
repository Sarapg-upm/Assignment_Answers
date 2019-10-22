require './Gene.rb'
require './Seed_stock.rb'
require './Hybrid_cross.rb'
require './functions.rb'



genes2 = Gene.insert_data("./gene_information.tsv")

#for i in genes2
#  puts i.gene_ID,i.name,i.mutant_phenotype
#end

#puts genes2[1].gene_ID,genes2[1].name,genes2[1].mutant_phenotype

my_seed_stock = Seed_stock.insert_data("./seed_stock_data.tsv")
for object in my_seed_stock
  #puts i.mutant_gene_ID,i.seed_stock,i.last_planted,i.grams_remaining
  puts object.seed_stock, object.grams_remaining
  
  object.plant_seed(7)
  
  puts object.seed_stock, object.grams_remaining
  
  
end


#puts genes2[1].mutant_gene_ID,genes2[1].seed_stock,genes2[1].last_planted

genes2 = Hybrid_cross.insert_data("./cross_data.tsv")
#for i in genes2
#  puts i.parent1,i.parent2,i.F2_wild
#end
#puts genes2[1].parent1,genes2[1].parent2,genes2[1].F2_wild

#puts "Total genes"
#puts Gene.total_genes
#
#puts "Total stocks"
#puts Seed_stock.total_stocks

