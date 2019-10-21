require 'csv'
require './Gene.rb'
#require './Seed_stock.rb'
require './2s.rb'

my_csv = CSV.read("gene_information.tsv", headers: true,  :col_sep => "\t" )
puts my_csv

for i in my_csv;
  Gene.new(i)
end

my_csv2 = CSV.read("seed_stock_data.tsv", headers: true,  :col_sep => "\t" )
puts my_csv2

for i in my_csv2;
  Seed_stock.new(i)
end


#p = Seed_stock.new()
#puts p.mutant_gene_ID, p.seed_stock, p.last_planted, p.storage, p.grams_remaining
#
#puts; puts
#
#puts "New stock\t"
#p2 = Seed_stock.new(
#  "00000001",  
#  "storage1", 
#  "date1",
#  "cama1",
#  2,
#  )
#
#puts p2.mutant_gene_ID, p2.seed_stock, p2.last_planted, p2.storage, p2.grams_remaining
#
#puts; puts

puts "Total genes"
puts Gene.total_genes

puts "Total stocks"
puts Seed_stock.total_stocks

puts Seed_stock.count