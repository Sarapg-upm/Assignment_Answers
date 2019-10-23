require './functions.rb'


class Hybrid_cross < Seed_stock

    attr_accessor :parent1  
    attr_accessor :parent2
    attr_accessor :F2_wild
    attr_accessor :F2_P1
    attr_accessor :F2_P2
    attr_accessor :F2_P1P2
    attr_accessor :N
    attr_accessor :linked_genes
    
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
        @parent1 = parms.fetch(:parent1, "0000")
        @parent2 = parms.fetch(:parent2, "0000")
        @F2_wild = parms.fetch(:F2_wild, 0)
        @F2_P1 = parms.fetch(:F2_P1, 0)
        @F2_P2 = parms.fetch(:F2_P2, 0)
        @F2_P1P2 = parms.fetch(:F2_P1P2, 0)
        @N = parms.fetch(:N, 0)
        @linked_genes = parms.fetch(:linked_genes, false)
    end
    
    def self.insert_data(data)
        
        data_array = Array.new
        my_csv=read_csv(data)
        for row in my_csv
          data_array << Hybrid_cross.new(
            :parent1 => row[0], 
            :parent2 => row[1], 
            :F2_wild => row[2].to_f ,
            :F2_P1 => row[3].to_f ,
            :F2_P2 => row[4].to_f ,
            :F2_P1P2 => row[5].to_f,
            :N => row[2].to_f + row[3].to_f + row[4].to_f + row[5].to_f,
            )
        end
        return data_array
    end
    
    def get_data
        object_data = [@parent1, @parent2, @F2_wild, @F2_P1, @F2_P2, @F2_P1P2, @N]    
        return object_data
    end
    
    def chi_square
        expected = [(9.0/16.0)*@N, (3.0/16.0)*@N, (3.0/16.0)*@N, (1.0/16.0)*@N]
        cross_data = self.get_data[2,5]
        observed_expected = 0
        4.times { |i| observed_expected += (((cross_data[i] - expected[i])**2)/expected[i])} 
        
        if observed_expected >= 3.84
            #name = self.get_gene_data
            #puts name
            puts "Recording:  #{self.get_gene_HYBRID(self.parent1)} is genetically linked to #{self.get_gene_HYBRID(self.parent2)} with chisquare score #{observed_expected}"
            puts
            puts "Final Report:\n#{self.get_gene_HYBRID(self.parent1)} is linked to #{self.get_gene_HYBRID(self.parent2)}\n#{self.get_gene_HYBRID(self.parent2)} is linked to #{self.get_gene_HYBRID(self.parent1)}"
            
            @linked_genes = true
            
        end
    end
    
    def get_gene_HYBRID(id)
        
        for object in @@data_seed_stock
            if object.seed_stock == id
                for objects_gene in @@data_genes
                    if objects_gene.gene_ID == object.mutant_gene_ID
                        return objects_gene.name
                    end
                end
            end
        end
    end
    
end

# =====================================================================================
