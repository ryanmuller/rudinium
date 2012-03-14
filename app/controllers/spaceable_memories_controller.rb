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
end
