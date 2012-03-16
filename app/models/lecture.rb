class Lecture < ActiveRecord::Base
  has_many :items
  
  default_scope :order => :number
end
