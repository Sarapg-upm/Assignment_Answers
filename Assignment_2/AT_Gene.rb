require './functions.rb'
require './KEGG_Pathway.rb'
require './GO.rb'

class AT_Gene 

    attr_accessor :TAIR_ID  
    attr_accessor :KEGG_ID
    attr_accessor :GO_ID
        
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
      @TAIR_ID = parms.fetch(:TAIR_ID, "AT0G00000")
      @KEGG_ID = parms.fetch(:KEGG_ID, "ath00000")
      @GO_ID = parms.fetch(:GO_ID, "GO:000000")
    end
    
    def self.insert_data(data)
        
        @@data_genes = Array.new
        my_csv=read_csv(data)
        for row in my_csv
          @@data_genes << AT_Gene.new(
            :TAIR_ID => row[0], 
            :KEGG_ID => KEGG_Pathway, 
            :GO_ID => GO 
            )
        end
        return @@data_genes
    end
    
end

