class Quiz < ActiveRecord::Base
  include QuizzesHelper

  belongs_to :item

  def as_json(options={})
    { :content => quizzify(self.content), :item_id => item_id, :video_id => video_id, :video_time => video_time, :video_end => video_end, :id => id }
  end
end
