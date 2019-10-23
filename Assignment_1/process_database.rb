require './Gene.rb'
require './Seed_stock.rb'
require './Hybrid_cross.rb'
require './functions.rb'

if ARGV.length != 4
  abort("Usage: ruby process_database.rb  gene_information.tsv  seed_stock_data.tsv  cross_data.tsv  new_stock_file.tsv")
end

begin
  genes = Gene.insert_data("./#{ARGV[0]}")
  my_seed_stock = Seed_stock.insert_data("./#{ARGV[1]}")
  hybrid_cross_objects = Hybrid_cross.insert_data("./#{ARGV[2]}")
  
  new_stock_path = "./#{ARGV[3]}"
  
  for object in my_seed_stock
    object.plant_seed(7)
  end
  
  Seed_stock.update_new_stock(my_seed_stock, new_stock_path)
  
  for object in hybrid_cross_objects
    object.chi_square
  end
rescue
   # handles error
  abort("Something went wrong!\nUsage: ruby process_database.rb  gene_information.tsv  seed_stock_data.tsv  cross_data.tsv  new_stock_file.tsv")
end
