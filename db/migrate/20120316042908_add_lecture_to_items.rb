class AddLectureToItems < ActiveRecord::Migration
  def change
    add_column :items, :lecture_id, :integer
  end
end
