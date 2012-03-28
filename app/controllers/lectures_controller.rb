class LecturesController < ApplicationController
  def index
    @lectures = Lecture.all
    @items = Item.all
  end

  def show
    @lecture = Lecture.find(params[:id])
    @items = @lecture.items
    @studying = current_user.nil? ? [] : current_user.studying
  end

end
