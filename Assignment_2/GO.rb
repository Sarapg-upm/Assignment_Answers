require './functions.rb'

class GO

    attr_accessor :GO_ID
    attr_accessor :name
        
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
      @GO_ID = parms.fetch(:GO_ID, "GO:000000")
      @name= parms.fetch(:name, "Some ontology name")
    end
    
    def self.insert_data(data)
        
        @@data_genes = Array.new
        my_csv=read_csv(data)
        for row in my_csv
          @@data_genes << Gene.new(
            :gene_ID => row[0], 
            :name => row[1], 
            :mutant_phenotype => row[2] 
            )
        end
        return @@data_genes
    end
    
end

