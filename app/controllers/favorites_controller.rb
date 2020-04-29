class FavoritesController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    current_user.favorite(item)
    flash[:success] ='商品をお気に入りしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    item = Item.find(params[:item_id])
    current_user.unfavorite(item)
    flash[:success] ='お気に入りを解除しました'
    redirect_back(fallback_location: root_path)
  end
end
