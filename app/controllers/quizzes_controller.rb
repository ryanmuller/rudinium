class QuizzesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @quiz = @item.quizzes.build(params[:quiz])

    if @quiz.save
      redirect_to items_path
    else
      redirect_to items_path
    end
  end
end

