class SpaceableMemoriesController < ApplicationController
  #before_filter :authenticate_user!

  def create
    #@item = Item.find(params[:spaceable_memory][:component_id])
    @item = Item.find(params[:memory][:item_id])
    current_user.learn!(@item)
    @memory = Spaceable::Memory.where(:learner_id => current_user.id, :component_id => @item).first
    respond_to do |format|
      format.json
    end
  end

  def index
    @memories = current_user.memories

    respond_to do |format|
      format.json
    end 
  end

  def show
    @memory = Spaceable::Memory.find(params[:id])
    if @memory.learner != current_user
      render :text => "You are not the owner of this memory."
      return false
    end

    respond_to do |format|
      format.json
    end
  end

  def update
    @memory = Spaceable::Memory.find(params[:id])
    @memory.view(params[:spaceable_memory][:quality].to_i)

    respond_to do |format|
      format.json
    end
  end
end
