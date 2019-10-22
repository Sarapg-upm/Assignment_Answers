require './functions.rb'


class Hybrid_cross

    attr_accessor :parent1  
    attr_accessor :parent2
    attr_accessor :F2_wild
    attr_accessor :F2_P1
    attr_accessor :F2_P2
    attr_accessor :F2_P1P2
    attr_accessor :N
    
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
        @parent1 = parms.fetch(:parent1, "0000")
        @parent2 = parms.fetch(:parent2, "0000")
        @F2_wild = parms.fetch(:F2_wild, 0)
        @F2_P1 = parms.fetch(:F2_P1, 0)
        @F2_P2 = parms.fetch(:F2_P2, 0)
        @F2_P1P2 = parms.fetch(:F2_P1P2, 0)
        @N = parms.fetch(:N, 0)
    end
    
    def self.insert_data(data)
        
        data_array = Array.new
        my_csv=read_csv(data)
        for row in my_csv
          data_array << Hybrid_cross.new(
            :parent1 => row[0], 
            :parent2 => row[1], 
            :F2_wild => row[2].to_i ,
            :F2_P1 => row[3].to_i ,
            :F2_P2 => row[4].to_i ,
            :F2_P1P2 => row[5].to_i,
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
        expected = [(9.0/16.0)*@N, (3.0/16.0)*@N, (3.0/16.0)*@N, (3.0/16.0)*@N]
        puts expected

    end
end

# =====================================================================================
