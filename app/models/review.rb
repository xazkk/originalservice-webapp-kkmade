class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  validates :rating, numericality: { greater_than_or_equal_to:1 ,less_than_or_equal_to:5 }
  validates :content, presence: true
end
