


class Seed_stock

include ObjectSpace
  
    attr_accessor :mutant_gene_ID  
    attr_accessor :seed_stock
    attr_accessor :last_planted
    attr_accessor :storage
    attr_accessor :grams_remaining
    
    @@number_of_stocks = 0 #class variable, it is shared within the class
    
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
      @mutant_gene_ID = parms.fetch(:mutant_gene_ID, "000000")
      @seed_stock = parms.fetch(:seed_stock, "storage0")
      @last_planted = parms.fetch(:last_planted, "date")
      @storage = parms.fetch(:storage, "cama0")
      @grams_remaining = parms.fetch(:grams_remaining, 3)
      
      @@number_of_stocks += 1
    end
    
    def self.total_stocks
      return @@number_of_stocks
    end
    
    def self.all
      ObjectSpace.each_object(self).to_a
    end

    
    def self.count
      ObjectSpace.each_object(self).count
    end
end

# =====================================================================================
