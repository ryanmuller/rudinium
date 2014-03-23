class ItemsController < ApplicationController
  def index
    @items = Item.includes(:memories, :quizzes).all # might be able to ditch "includes"
    @lectures = Lecture.all
    @quizzes = Quiz.order(:id)

    # creates JSON array of user's memories to pass to backbone.js app
    @memories = current_user.nil? ? [] : current_user.memories.map{|m| {:id => m.id, :due => m.due?, :item_id => m.component_id, :quizzes => m.component.quizzes.map{|q| q.id}}}
  end

end
