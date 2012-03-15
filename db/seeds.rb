# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'xmlsimple'
require 'open-uri'



# Item.all.each { |i| i.destroy }

# Gets data from server, initializes parsed hash
url = "https://spreadsheets.google.com/feeds/cells/0AjQWBGQVwam3dEwxYk11RW9sZVhUZnRxN0FwcTdWcGc/1/public/values"
open(url) do |d| 
  xml = XmlSimple.xml_in(d.read)
  data = Hash.new{ |hash, key| hash[key] = {} }

  # Parses the xml hash into a data hash.
  # for example, the contents of cell [3,5] ([row, col]) can be accessed as "data[3][5]"
  xml['entry'].each {|x| data[x['cell'][0]['row'].to_i].merge!({ x['cell'][0]['col'].to_i =>  x['cell'][0]['content'] } ) }

  # (note... key [row, col] values are indexed from 1)
  data.each do |key, value|
    if value[7] == "Definition" || value[7] == "Theorem" || value[7] == "Proof" || value[7] == "Notation"
      item = Item.find_or_create_by_id(value[1])
      item_info = { :lecture_id => value[2], :lecture_name => value[10], :rudin_pg => value[12], :rudin_eq => value[13], :rudin_ch => value[14], :rudin_section => value[18] }
      item.update_attributes({ name: value[6], label: value[7], video_id: value[3], video_time: value[4], video_end: value[5], content: value[9], item_info: item_info })
      item.save!
    end
  end
end

# sheet.each do |row|
#   if row[6] == "Definition" || row[6] == "Theorem" || row[6] == "Proof"
#     Item.create({ name: row[5], label: row[6], video_id: row[2], video_time: row[3], video_end: row[4], content: row[8] })
#   end
# end

