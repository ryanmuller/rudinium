# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Item.all.each { |i| i.destroy }
Item.create([{ name: 'Set', label: 'Definition', video_id: 'sqEyWLGvvdw', video_time: '857',
               content: 'A set is a collection of objects.' },
             { name: 'Subset', label: 'Definition', video_id: 'sqEyWLGvvdw', video_time: '1260',
               content: 'If \( x \in A \) then \( x \in B \) (or \( x \in A \Leftarrow x \in B \)).' }])

