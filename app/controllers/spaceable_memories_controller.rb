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
    @due_memories = current_user.memories.due_before(Time.now.utc)
    @memories = current_user.memories

    respond_to do |format|
      format.html {
        if @due_memories.count > 0
          redirect_to @due_memories.first
        else
          render :layout => false
        end
      }
      format.js { render :json => @due_memories.map { |m| {:id => m.id,  :item_id => m.component_id, :quizzes => m.component.quizzes.map{|q| q.id} } } }
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
      format.html { render :layout => false }
    end
  end

  def update
    @memory = Spaceable::Memory.find(params[:id])
    @memory.view(params[:spaceable_memory][:quality].to_i)
    respond_to do |format|
      format.json
    end
  end

  # can possibly garbage collect "due" and "memories" functions -- lumped in with
  # show/index (and added a "due": true/false parameter to json response)
  def due
    @memories = current_user.due_memories
    respond_to do |format|
      format.json
    end
  end

  def memories
    @memories = current_user.memories
    respond_to do |format|
      format.json
    end
  end

  def memory
    @memory = Spaceable::Memory.find(params[:id])
    respond_to do |format|
      format.json
    end
  end
end
