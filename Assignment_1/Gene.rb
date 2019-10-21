
class Gene
#
    attr_accessor :gene_ID  
    attr_accessor :name
    attr_accessor :mutant_phenotype
    
    @@number_of_genes = 0 #class variable, it is shared within the class
    
    def initialize (
        thisID = "00000000", 
        thisname = "gen0", 
        thisMutPhenotype = "phenotype0" 
    ) # get a name from the "new" call, or set a default
      
      @gene_ID = thisID
      @name = thisname
      @mutant_phenotype = thisMutPhenotype
      
      @@number_of_genes += 1
    end
    
    def self.total_genes
      return @@number_of_genes
    end
end

