class AddVideoInfoToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :video_id, :string
    add_column :quizzes, :video_time, :integer
    add_column :quizzes, :video_end, :integer
  end
end
