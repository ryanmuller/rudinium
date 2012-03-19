class Item < ActiveRecord::Base
  has_many :quizzes
  belongs_to :lecture 

  serialize :item_info, Hash
  default_scope order('lecture_id ASC, video_time ASC')
  acts_as_component

  def item_info
    read_attribute(:item_info) || write_attribute(:item_info, {})
  end
end
