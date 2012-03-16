class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :title
      t.string :video_id
      t.integer :number

      t.timestamps
    end
  end
end
