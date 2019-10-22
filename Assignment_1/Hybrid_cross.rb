require './functions.rb'


class Hybrid_cross

    attr_accessor :parent1  
    attr_accessor :parent2
    attr_accessor :F2_wild
    attr_accessor :F2_P1
    attr_accessor :F2_P2
    attr_accessor :F2_P1P2
        
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
        @parent1 = parms.fetch(:parent1, "0000")
        @parent2 = parms.fetch(:parent2, "0000")
        @F2_wild = parms.fetch(:F2_wild, 0)
        @F2_P1 = parms.fetch(:F2_P1, 0)
        @F2_P2 = parms.fetch(:F2_P2, 0)
        @F2_P2 = parms.fetch(:F2_P2, 0)
      
    end
    
    def self.insert_data(data)
        
        data_array = Array.new
        my_csv=read_csv(data)
        for row in my_csv
          data_array << Hybrid_cross.new(
            :parent1 => row[0], 
            :parent2 => row[1], 
            :F2_wild => row[2],
            :F2_P1 => row[3],
            :F2_P2 => row[4],
            :F2_P1P2 => row[5]
            )
        end
        return data_array
    end
end

# =====================================================================================
