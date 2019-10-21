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
end

# =====================================================================================
