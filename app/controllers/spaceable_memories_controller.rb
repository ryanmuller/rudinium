class SpaceableMemoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @item = Item.find(params[:spaceable_memory][:component_id])
    current_user.learn!(@item)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def index
    @due_memories = current_user.memories.due_before(Time.now.utc)

    if @due_memories.count > 0
      redirect_to @due_memories.first
    else
      redirect_to root_path
    end
  end

  def show
    @memory = Spaceable::Memory.find(params[:id])
  end

  def update
    @memory = Spaceable::Memory.find(params[:id])
    @memory.view(params[:spaceable_memory][:quality].to_i)
    redirect_to spaceable_memories_path
  end
end
