class SpaceableMemoriesController < ApplicationController
  def create
    current_user.learn(Item.find(params[:spaceable_memory][:component_id]))
    redirect_to root_path
  end
end
