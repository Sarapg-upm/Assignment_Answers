require './functions.rb'

class KEGG_Pathway

    attr_accessor :KEGG_ID
    attr_accessor :name
        
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
      @KEGG_ID = parms.fetch(:KEGG_ID, "ath00000")
      @name= parms.fetch(:name, "Some pathway name")
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

