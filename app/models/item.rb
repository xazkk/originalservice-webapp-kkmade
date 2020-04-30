class Item < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true
    validates :content, presence: true
    validates :item_code, presence: true, uniqueness: true
    
    has_many :favorites
    has_many :liked_items, through: :favorites, source: :user
    
    #def existed?(item)
      #items.exists?(item_code: item.item_code)
    #end
end
