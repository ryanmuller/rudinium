class QuizzesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @quiz = @item.quizzes.build(params[:quiz])

    if @quiz.save
      respond_to do |format|
        format.html { redirect_to items_path }
        format.js
      end
    else
      redirect_to items_path
    end
  end
end

