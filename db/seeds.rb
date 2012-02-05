# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'xmlsimpe'
require 'open-uri'



Item.all.each { |i| i.destroy }

# Gets data from server, initializes parsed hash
xml = XmlSimple.xml_in(open("https://spreadsheets.google.com/feeds/cells/0AjQWBGQVwam3dEwxYk11RW9sZVhUZnRxN0FwcTdWcGc/1/public/values").string)
data = Hash.new{ |hash, key| hash[key] = {} }

# Parses the xml hash into a data hash.
# for example, the contents of cell [3,5] ([row, col]) can be accessed as "data[3][5]"
xml['entry'].each {|x| data[x['cell'][0]['row'].to_i].merge!({ x['cell'][0]['col'].to_i =>  x['cell'][0]['content'] } ) }

# (note... key [row, col] values are indexed from 1)
data.each do |key, value|
  if value[7] == "Definition" || row[7] == "Theorem" || row[7] == "Proof"
    Item.create({ name: row[6], label: row[7], video_id: row[3], video_time: row[4], video_end: row[5], content: row[9] })
  end
end

# sheet.each do |row|
#   if row[6] == "Definition" || row[6] == "Theorem" || row[6] == "Proof"
#     Item.create({ name: row[5], label: row[6], video_id: row[2], video_time: row[3], video_end: row[4], content: row[8] })
#   end
# end

