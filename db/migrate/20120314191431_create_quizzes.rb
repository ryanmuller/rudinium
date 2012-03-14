class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.text :content
      t.references :item

      t.timestamps
    end
    add_index :quizzes, :item_id
  end
end
