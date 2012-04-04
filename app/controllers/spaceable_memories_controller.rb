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

    respond_to do |format|
      format.html {
        if @due_memories.count > 0
          redirect_to @due_memories.first
        else
          render :layout => false
        end
      }
      format.js { render :json => @due_memories.map { |m| {:id => m.id,  :item_id => m.component_id, :quizzes => m.component.quizzes.map{|q| q.id} } } }
    end 
  end

  def show
    @memory = Spaceable::Memory.find(params[:id])
    render :layout => false
  end

  def update
    @memory = Spaceable::Memory.find(params[:id])
    @memory.view(params[:spaceable_memory][:quality].to_i)
    respond_to do |format|
      format.html { redirect_to spaceable_memories_path }
      format.js
    end
  end
end
