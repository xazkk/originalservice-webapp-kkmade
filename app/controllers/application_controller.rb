class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def fav_counts(user)
    @count_likes = user.likes.count
  end
  
  def fav_counts_item(item)
    @count_liked_items = item.liked_items.count
  end
  
  def rev_counts(user)
    @count_coments = user.coments.count
  end
  
  def rev_counts_item(item)
    @count_comented_items = item.comented_items.count
  end
end
