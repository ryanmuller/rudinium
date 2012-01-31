class AddVideoEndTime < ActiveRecord::Migration
  def change
    add_column :items, :video_end, :integer
  end
end
