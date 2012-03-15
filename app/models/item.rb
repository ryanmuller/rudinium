class Item < ActiveRecord::Base
  has_many :quizzes
  serialize :item_info, Hash
  acts_as_component

  def item_info
    read_attribute(:item_info) || write_attribute(:item_info, {})
  end
end
