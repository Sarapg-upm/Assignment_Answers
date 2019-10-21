require 'csv'
require './Gene.rb'
require './Seed_stock.rb'
require './functions.rb'


#my_csv = read_csv ('./gene_information.tsv')

#gene_df = Hash.new

#genes = []
#j = 0
#CSV.foreach('./gene_information.tsv', headers: true, :col_sep => "\t") do |row|
#  puts row.inspect
#  genes[j] = Gene.new(
#    :gene_ID => row[0], 
#    :name => row[1], 
#    :mutant_phenotype => row[2], 
#  )
#  j += 1
#end
#
#puts genes[0].gene_ID,genes[0].name,genes[0].mutant_phenotype


#genes2 = []
#j = 0
#my_csv=read_csv("./gene_information.tsv")
#for row in my_csv
#  #puts row.inspect
#  genes2[j] = Gene.new(
#    :gene_ID => row[0], 
#    :name => row[1], 
#    :mutant_phenotype => row[2], 
#    )
#  j += 1
#end
atibutes_gene = ["gene_ID", "name", "mutant_phenotype"]
genes2 = insert_data_in_class("./gene_information.tsv", Gene, atibutes_gene)

puts genes2[1].gene_ID,genes2[1].name,genes2[1].mutant_phenotype
#puts gene_df
#for i in my_csv;
#  genes[i] = Gene.new(i)
#end
#puts gene_df
#my_csv2 = read_csv ('./seed_stock_data.tsv')
#for i in my_csv2;
#  Seed_stock.new(i)
#end


puts "Total genes"
puts Gene.total_genes

puts "Total stocks"
puts Seed_stock.total_stocks

puts Seed_stock.count
