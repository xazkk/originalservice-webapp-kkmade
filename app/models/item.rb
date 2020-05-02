class Item < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true
    validates :content, presence: true
    validates :item_code, presence: true, uniqueness: true
    
    has_many :favorites
    has_many :liked_items, through: :favorites, source: :user
    
    def self.create_fav_ranking
      Item.find(Favorite.group(:item_id).order('count(item_id) desc').limit(15).pluck(:item_id))
    end
end
