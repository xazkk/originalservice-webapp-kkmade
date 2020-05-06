class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews
    @users = User.order(id: :desc)
  end
  
  def new
    @review = Review.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:success] ='レビューを投稿しました'
      redirect_to item_reviews_path(@item)
    else
      flash.now[:danger] = 'レビューを投稿できませんでした'
      render :new
    end
  end

  def edit
    @item = Item.find(params[:item_id])
    @review = @item.reviews.find(params[:id])
  end

  def update
    @item = Item.find(params[:item_id])
    @review = @item.reviews.find(params[:id])
    if (@review.user_id == current_user.id)
      if @review.update(review_params)
        flash[:success] ='レビューを編集しました'
        redirect_to item_reviews_path(@item)
      else
        flash.now[:danger] = 'レビューを編集できませんでした'
        render :edit
      end
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @review = @item.reviews.find(params[:id])
    @review.destroy
    flash[:success] ='レビューを削除しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def review_params
    params.require(:review).permit(:rating, :content)
  end
  
  def correct_user
    @Item = Item.find(params[:item_id])
    @review = @Item.reviews.find_by(id: params[:id])
    if @review == nil || @review.user_id != current_user.id 
      redirect_to root_path
    end
  end
end
