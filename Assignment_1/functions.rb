require 'csv'

def read_csv (path, header = true, sep = "\t")
  
  my_csv = CSV.read(path, headers: header,  :col_sep => sep)
  
  return my_csv
end

#def insert_data_in_class(csv, my_class, attributes)
#  
#  objects = []
#  j = 0
#  k = 0
#  my_csv=read_csv(csv)
#  
#  for row in my_csv
#    for i in attributes
#      objects[j] = my_class.new(attributes[i] => row[k])
#      k +=1
#    end
#    j += 1
#  end
#end
##
#def insert_data_in_class(csv, my_class)
#  
#  objects = []
#  j = 0
#  my_csv = read_csv(csv)
#  
#  for row in my_csv
#    #puts row.inspect
#    objects[j] = my_class.new(
#      :gene_ID => row[0], 
#      :name => row[1], 
#      :mutant_phenotype => row[2], 
#      )
#    j += 1
#  end
#  
#  return objects
#end