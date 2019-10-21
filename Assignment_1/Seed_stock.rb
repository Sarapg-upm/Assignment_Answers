


class Seed_stock

include ObjectSpace
  
    attr_accessor :mutant_gene_ID  
    attr_accessor :seed_stock
    attr_accessor :last_planted
    attr_accessor :storage
    attr_accessor :grams_remaining
    
    @@number_of_stocks = 0 #class variable, it is shared within the class
    
    def initialize (
        thisID = "00000000", 
        thisname = "storage0", 
        thislast_planted = "date",
        thisstorage = "cama0",
        thisgrams_remaining = 3
      ) # get a name from the "new" call, or set a default
      
      @mutant_gene_ID = thisID
      @seed_stock = thisname
      @last_planted = thislast_planted
      @storage = thisstorage
      @grams_remaining = thisgrams_remaining
      
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
