require 'rest-client'   # this is how you access the Web
require './functions.rb'
require 'ruby-progressbar'
require 'json'


class Interaction_Network 

    attr_accessor :TAIR_ID
    attr_accessor :interactors
    attr_accessor :KEGG_pathway_ID
    attr_accessor :KEGG_pathway_name
    attr_accessor :GO_ID
    attr_accessor :GO_name
        
    def initialize (parms = {}) # get a name from the "new" call, or set a default
      
        @TAIR_ID = parms.fetch(:TAIR_ID, "AT0G00000") #there is no AT0G00000 code
        @interactors = parms.fetch(:interactors, []) #all TAIR_codes that interact with or TAIR_ID gene
        @KEGG_ID = parms.fetch(:KEGG_ID, []) #There is no ath00000 code
        @KEGG_pathway_name = parms.fetch(:KEGG_pathway_name, [])
        @GO_ID = parms.fetch(:GO_ID, []) #the is no GO:000000 code
        @GO_name = parms.fetch(:GO_name, [])

    end
    
    def self.insert_data(data)
        
        @@data_genes = Array.new
        my_codes = read_csv(data, false, "\n").flatten!
        uppercase(my_codes)
        interactors_codes = Array.new
        kegg_data = Array.new
        go_data = Array.new
        progressbar = ProgressBar.create(:total => my_codes.size,
                                         :format => '%t |%b|%i| %p%% ',
                                         :progress_mark  => '=',
                                         :remainder_mark => " ",
                                         :title => "Looking for interactors ")

        for code in my_codes
            
            tab25 = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code}?format=tab25"
            res = fetch(tab25)
            all_codes = res.body.scan(/AT\dG\d{0,5}/i)
            uppercase(all_codes) #uppercase all the code to compare
            check_codes = all_codes & my_codes #intersection, looking for codes in my_codes
            check_codes -= [code] #initial code is always going to be there
            
            if check_codes.any? #if we have interactor/s

                interactors_codes += check_codes #save the codes
                kegg_data = Interaction_Network.get_KEGG_pathways(code) #search for the keeg id and name
                go_data = Interaction_Network.get_GO_info(code) #seach for GO id and name
                #creating objects
                @@data_genes << Interaction_Network.new(
                :TAIR_ID => code,
                :interactors => interactors_codes,
                :KEGG_ID => kegg_data[0],
                :KEGG_pathway_name => kegg_data[1],
                :GO_ID => go_data[0],
                :GO_name => go_data[1])
            end
            progressbar.increment
            sleep 0.1
        end
        
        return @@data_genes
    end
    
    def self.get_KEGG_pathways(code)
        kegg_gene = "http://togows.org/entry/kegg-genes/ath:#{code}.json"
        res = fetch(kegg_gene)
        data = JSON.parse(res.body)
        kegg_path, kegg_name = Array.new, Array.new
        
        if data[0]["pathways"].each.any?
            for elem in data[0]["pathways"]
                kegg_path <<  elem[0]
                kegg_name << elem[1]
            end
        end
        return kegg_path, kegg_name
    end
    
    def self.get_GO_info(code)
        go_query = "http://togows.dbcls.jp/entry/uniprot/#{code}/dr.json" 

        res = fetch(go_query)
        data = JSON.parse(res.body)
        go_id, go_name = Array.new, Array.new

        for go in data[0]["GO"].each
            if (go[1]=~ /^P:/)
                go_id << go[0]
                go_name << go[1]
                #puts "GO_ID:#{go[0]}\tname: #{go[1]}"
            end
        end
        return go_id.uniq, go_name.uniq
    end

    def get_data_for_report
        object_data = [@TAIR_ID, @interactors.join("|"), @KEGG_ID.join("|"), @KEGG_pathway_name.join("|"), @GO_ID.join("|"), @GO_name.join("|")]    
        return object_data
    end
        
    def self.get_report(path)
        @Interaction_Network_data = Array.new
        for object in @@data_genes
          @Interaction_Network_data << object.get_data_for_report
        end
        header = ["TAIR_code", "Interactors", "KEGG_Pathways_ID", "KEGG_Pathways_name", "GO_ID", "GO_name"]
        write_csv(path, @Interaction_Network_data, "\t", header)
    end
end

