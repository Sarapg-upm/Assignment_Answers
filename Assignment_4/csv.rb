require 'csv'

row = ["a","b","c","d"]
row2 = ["1", "2", "3"]

CSV.open("try.csv", "a+") do |csv|
  csv << row
  csv << row2
end

CSV.open("try.csv", "wb") do |csv|
  csv << row
  csv << row2
end