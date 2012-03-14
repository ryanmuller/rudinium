class ItemsController < ApplicationController
  def index
    @items = Item.includes(:memories).all
  end

end
