require './Gene.rb'
require './Seed_stock.rb'
require './Hybrid_cross.rb'
require './functions.rb'



genes = Gene.insert_data("./gene_information.tsv")

my_seed_stock = Seed_stock.insert_data("./seed_stock_data.tsv")

path = './new_stock_file.tsv'

for object in my_seed_stock
  object.plant_seed(7)
end

Seed_stock.update_new_stock(my_seed_stock, path)

hybrid_cross_objects = Hybrid_cross.insert_data("./cross_data.tsv")

for object in hybrid_cross_objects
  object.chi_square
end

#puts hybrid_cross_objects[0].say("from my_code")
#puts my_seed_stock[0].get_gene_name(my_seed_stock[0].mutant_gene_ID)
#puts hybrid_cross_objects[0].get_gene_HYBRID(hybrid_cross_objects[0].parent1)
#puts Hybrid_cross.get_gene_data
#puts Hybrid_cross.methods