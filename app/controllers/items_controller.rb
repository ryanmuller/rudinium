class ItemsController < ApplicationController
  def index
    @items = Item.includes(:memories, :quizzes).all
    @studying = current_user.nil? ? [] : current_user.studying
  end

end
