class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews
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
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'レビューを投稿できませんでした'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @review = Review.find(params[:id])
    @item = Item.find(params[:item_id])
  end

  def update
    @item = Item.find(params[:item_id])
    @review = @item.reviews.build(review_params)
    if @review.save
      flash[:success] ='レビューを投稿しました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'レビューを投稿できませんでした'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    
  end
  
  private
  
  def review_params
    params.require(:review).permit(:reting, :content)
  end
end
