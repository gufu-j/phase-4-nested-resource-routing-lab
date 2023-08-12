class ItemsController < ApplicationController

 rescue_from ActiveRecord::RecordNotFound,  with: :set_alarm
  # def index
  #   items = Item.all
  #   render json: items, include: :user
  # end

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
      else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  # def create
  #   user = User.find(params[:user_id])
  #   item = user.items.create(item_params)
  #   render json: :item, status: :created
  # end

  def create
    user = find_user
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  

  private

  def set_alarm
      render json: {error: 404}, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price)
  end
  
  def find_user
    User.find(params[:user_id])
  end




end
