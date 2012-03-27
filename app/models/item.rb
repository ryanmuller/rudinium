class Item < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper

  has_many :quizzes
  belongs_to :lecture 

  serialize :item_info, Hash
  default_scope order('lecture_id ASC, video_time ASC')
  acts_as_component

  def item_info
    read_attribute(:item_info) || write_attribute(:item_info, {})
  end

  # override as_json to use formatted content
  def as_json(options={})
    { :name => name, :content => formatted_content, :label => label, :video_id => video_id, :video_time => video_time, :video_end => video_end, :item_info => item_info, :lecture_id => lecture_id, :id => id }
  end

  def formatted_content
    simple_format(self.content)
  end
end
