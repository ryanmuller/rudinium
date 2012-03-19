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
  lectures = Hash.new{ |hash, key| hash[key] = {} }

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

      unless lectures.has_key?(value[2])
        lectures[value[2]] = { :title => value[10], :video_id => value[3], :number => value[2] }
      end
    end
  end

  lectures.each do |key, value|
    lecture = Lecture.find_or_create_by_id(key)
    lecture.update_attributes(value)
    lecture.save!
  end
end

Item.all.each do |i|
  Lecture.find(i.item_info[:lecture_id]).items << i ## I bet there's a much more efficient way to do this... but i'm feeling lazy
end

# remove all item associations
Item.all.each do |item|
  item.quizzes = []
  item.save!
end

quizzes_url = "https://spreadsheets.google.com/feeds/cells/0AjQWBGQVwam3dEwxYk11RW9sZVhUZnRxN0FwcTdWcGc/ocy/private/full"

open(quizzes_url) do |d|
  xml = XmlSimple.xml_in(d.read)
  data = Hash.new{ |hash, key| hash[key] = {} }

  xml['entry'].each {|x| data[x['cell'][0]['row'].to_i].merge!({ x['cell'][0]['col'].to_i =>  x['cell'][0]['content'] } ) }

  # (note... key [row, col] values are indexed from 1)
  data.each do |key, value|
    # create or update quiz
    quiz = Quiz.find_or_create_by_id(value[1])
    quiz.update_attributes({ :content => value[8], :video_id => value[4], :video_time => value[5], :video_end => value[6] })
    quiz.save!


    # create new association
    item = Item.find(value[2])
    if item
      item.quizzes << quiz
    end
  end
end

