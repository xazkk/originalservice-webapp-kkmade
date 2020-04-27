class Item < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true
    validates :content, presence: true
    validates :item_code, presence: true, uniqueness: true
end
