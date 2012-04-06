class SpaceableMemoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @item = Item.find(params[:spaceable_memory][:component_id])
    current_user.learn!(@item)
    respond_to do |format|
      format.js
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
