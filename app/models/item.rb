class Item < ApplicationRecord
    validates :name, presence: true, length: { maximum: 255 }
    validates :price, presence: true, length: { maximum: 50 }
    validates :content, presence: true, length: { maximum: 255 }
    validates :item_code, presence: true, length: { maximum: 50 }, uniqueness: true
end
