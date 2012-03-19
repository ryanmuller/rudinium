class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :content
      t.string :type
      t.string :video_id
      t.integer :video_time

      t.timestamps
    end
  end
end
