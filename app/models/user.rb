class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                uniqueness: { case_sensitive: false }
  has_secure_password
  
  mount_uploader :image, ImageUploader
  
  has_many :favorites
  has_many :likes, through: :favorites, source: :item
  has_many :reviews
  has_many :coments, through: :reviews, source: :item
  
  def favorite(item)
    self.favorites.find_or_create_by(item_id: item.id)
  end  
    
  def unfavorite(item)
    fav_item = self.favorites.find_by(item_id: item.id)
    fav_item.destroy if fav_item
  end  
  
  def liked?(item)
    self.likes.include?(item)
  end
  
  def reviewd?(item)
    self.coments.include?(item)
  end  
end
