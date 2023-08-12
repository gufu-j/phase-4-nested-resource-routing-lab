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

  def create
    item = Item.create(review_params)
    render json: :item, status: :created
  end

  

  private

  def set_alarm
      render json: {error: 404}, status: :not_found
  end

  def review_params
    params.permit(:name, :description, :price)
  end




end
