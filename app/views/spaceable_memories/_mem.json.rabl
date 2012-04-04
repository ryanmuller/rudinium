collection @memories, :object_root => false

attribute :component_id => :item_id
node :quizzes do |m|
  m.component.quizzes.map{|q| q.id }
end
