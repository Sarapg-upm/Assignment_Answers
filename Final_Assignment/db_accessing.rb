require 'sparql/client'

endpoint = "http://localhost:9999/blazegraph/namespace/drugbank/sparql"  

query = <<END
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX db:<http://openlifedata.org/drugbank_vocabulary:>
SELECT ?brandname ?enzymename ?func
WHERE {
  ?d a db:Drug .
  ?d db:target ?enzyme .
  ?d db:brand ?brand .
  ?brand rdfs:label ?brandname .
  ?enzyme a db:Enzyme.
  ?enzyme rdfs:label ?enzymename .
  ?enzyme db:specific-function ?func .
  FILTER (regex(str(?func), "coagulation", "i")) .
   	} LIMIT 100
END

sparql = SPARQL::Client.new(endpoint)  # create a SPARQL client
result = sparql.query(query)  # Execute query

result.each do |solution|
  puts "Name  #{solution[:brandname]}   “
  puts “Enzyme #{solution[:enzymename]} Function #{solution[:func]}\n"
end


