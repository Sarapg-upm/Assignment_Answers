require 'rest-client'   # this is how you access the Web
require './functions.rb'
require 'ruby-progressbar'
require 'json'


class AT_Gene 

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
                                         :format => '%t %a |%b|%i| %p%% ',
                                         :progress_mark  => '=',
                                         :remainder_mark => " ",
                                         :title => "Getting Data ")

        for code in my_codes
            
            tab25 = "http://www.ebi.ac.uk/Tools/webservices/psicquic/intact/webservices/current/search/interactor/#{code}?format=tab25"
  
            res = fetch(tab25)

            all_codes = res.body.scan(/AT\dG\d{0,5}/i)
          
            uppercase(all_codes)
            check_codes = all_codes & my_codes
            check_codes -= [code]
            
            if check_codes.any?
                #puts code
                interactors_codes += check_codes

                kegg_data = AT_Gene.get_KEGG_pathways(code)
                go_data = AT_Gene.get_GO_info(code)
                
                @@data_genes << AT_Gene.new(
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
        
        if data[0]["pathways"].any?
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

        for go in data[0]["GO"]
            if (go[1]=~ /^P:/)
                go_id << go[0]
                go_name << go[1]
                #puts "GO_ID:#{go[0]}\tname: #{go[1]}"
            end
        end
        return go_id.uniq, go_name.uniq
    end

    def get_data
        object_data = [@TAIR_ID, @interactors, @KEGG_ID, @KEGG_pathway_name, @GO_ID, @GO_name]    
        return object_data
    end
end

