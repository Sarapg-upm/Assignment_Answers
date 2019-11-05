require './functions.rb'
require './AT_Gene.rb'

class Interaction_Network < AT_Gene

    attr_accessor :TAIR_ID_1
    attr_accessor :TAIR_ID_2
    attr_accessor :type_of_interection
        
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
        @TAIR_ID_1 = parms.fetch(:TAIR_ID_1, "AT0G00000")
        @TAIR_ID_2 = parms.fetch(:TAIR_ID_2, "AT0G00000")
        @type_of_interection = parms.fetch(:type_of_interection, "some kind of interaction")
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

