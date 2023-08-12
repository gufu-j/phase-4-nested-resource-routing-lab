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


  private

  def set_alarm
      render json: {error: 404}, status: :not_found
  end



end
