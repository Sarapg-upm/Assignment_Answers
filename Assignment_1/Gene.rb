require './functions.rb'

class Gene

    attr_accessor :gene_ID  
    attr_accessor :name
    attr_accessor :mutant_phenotype
    
    @@number_of_genes = 0 #class variable, it is shared within the class
    
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
      @gene_ID = parms.fetch(:gene_ID, "00000")
      @name = parms.fetch(:name, "gene0")
      @mutant_phenotype = parms.fetch(:mutant_phenotype, "blah blah some phenotype")
      
      @@number_of_genes += 1
    end
    
    def self.total_genes
      return @@number_of_genes
    end
    
    def self.insert_data(data)
        
        data_array = Array.new
        my_csv=read_csv(data)
        for row in my_csv
          data_array << Gene.new(
            :gene_ID => row[0], 
            :name => row[1], 
            :mutant_phenotype => row[2] 
            )
        end
        return data_array
    end
    
    
end

