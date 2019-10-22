require './Gene.rb'
require './Seed_stock.rb'
require './Hybrid_cross.rb'
require './functions.rb'



genes2 = Gene.insert_data("./gene_information.tsv")

my_seed_stock = Seed_stock.insert_data("./seed_stock_data.tsv")

path = './new_stock_file.tsv'

for object in my_seed_stock
  object.plant_seed(7)
end

Seed_stock.update_new_stock(my_seed_stock, path)

genes2 = Hybrid_cross.insert_data("./cross_data.tsv")
