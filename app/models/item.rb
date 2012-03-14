class Item < ActiveRecord::Base
  has_many :quizzes
  acts_as_component
end
