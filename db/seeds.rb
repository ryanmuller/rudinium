# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Item.all.each { |i| i.destroy }

DATA_FILE = File.join( File.dirname(__FILE__), '..', 'data/data.xls' )
book = Spreadsheet.open(DATA_FILE)
sheet = book.worksheet 'Items'

sheet.each do |row|
  if row[6] == "Definition" || row[6] == "Theorem"
    Item.create({ name: row[5], label: row[6], video_id: row[2], video_time: row[3], video_end: row[4], content: row[8] })
  end
end

