class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_likes = user.likes.count
    @count_coments = user.coments.count
  end
  
  def item_counts(item)
    @count_liked_items = item.liked_items.count
    @count_comented_items = item.comented_items.count
  end
end
