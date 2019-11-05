require './functions.rb'
require 'json'
require 'rest-client'

class KEGG_Pathway

    attr_accessor :KEGG_ID
    attr_accessor :name
        
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
      @KEGG_ID = parms.fetch(:KEGG_ID, "ath00000")
      @name= parms.fetch(:name, "Some pathway name")
    end
    
    def self.insert_data(data)
        
        @@data_KEGG = Array.new
        my_csv=read_csv(data)
        for row in my_csv
          @@data_KEGG << KEGG_Pathway.new(
            :KEGG_ID => row[0], 
            :name => row[1]
            )
        end
        return @@data_KEGG
    end
    
    def access_web(code)
        
        kegg_gene = "http://togows.org/entry/kegg-genes/ath:#{code}.json"
        res = fetch(kegg_gene)
        data = JSON.parse(res.body)
        puts "This code #{code}"
        for elem in data[0]["pathways"].each
        #   puts elem
          puts "\tKEGG_Pathway ID: #{elem[0]}  name: #{elem[1]}"
        end
    end
end

