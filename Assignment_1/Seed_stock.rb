require './functions.rb'

class Seed_stock < Gene
    
    include Enumerable
    extend Forwardable
    
    attr_accessor :seed_stock  
    attr_accessor :mutant_gene_ID
    attr_accessor :last_planted
    attr_accessor :storage
    attr_accessor :grams_remaining
    
    @@number_of_stocks = 0 #class variable, it is shared within the class
    @@my_seed_stock = Array.new
    
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
    
    def self.insert_data(data)
        
        @@data_seed_stock = Array.new
        my_csv=read_csv(data)
        for row in my_csv
          @@data_seed_stock << Seed_stock.new(
            :seed_stock => row[0], 
            :mutant_gene_ID => row[1], 
            :last_planted => row[2],
            :storage => row[3],
            :grams_remaining => row[4].to_i 
            )
        end
        return @@data_seed_stock
    end
    
    def plant_seed(grams_planted)
        
        @grams_remaining -= grams_planted
        
        if  @grams_remaining <= 0
            @grams_remaining = 0
            puts "WARNING: we have run out of Seed Stock #{self.seed_stock}!"
        end
    end
    
    def get_data
        object_data = [@seed_stock, @mutant_gene_ID, @last_planted, @storage, @grams_remaining]
        return object_data
    end
    
    def self.update_new_stock(my_seed_stock, path)
        
        for object in my_seed_stock
          @@my_seed_stock << object.get_data
        end
        
        header = ["Seed_Stock", "Mutant_Gene_ID", "Last_Planted", "Storage", "Grams_Remaining"]
        write_csv('./new_stock_file.tsv', @@my_seed_stock, "\t", header)
        @@my_seed_stock = Array.new
    end
    
    #def get_gene_name(id)
    #    super
    #end
    
    #def get_gene_id(id)
    #    
    #    for object in @@data_array
    #        if object.seed_stock == id 
    #            return object.mutant_gene_ID
    #        end
    #    end
    #end
    
    #def get_gene_name(id)
    #    
    #    for object in @@data_genes
    #        if object.gene_ID == id 
    #            return object.name
    #        end
    #    end
    #end
    #
end

# =====================================================================================
