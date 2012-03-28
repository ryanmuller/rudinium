class Lecture < ActiveRecord::Base
  has_many :items
  
  default_scope :order => :number


  # override as_json to get item_list
  def as_json(options={})
    item_list = self.items.map { |i| i.id }
    { :title => title, :video_id => video_id, :number => number, :items => item_list, :id => id }
  end 
end
