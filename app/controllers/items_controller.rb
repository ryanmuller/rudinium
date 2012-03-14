class ItemsController < ApplicationController
  def index
    @items = Item.includes(:memories, :quizzes).all
  end

end
