class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  validates :rating, presence: true
  validates :content, presence: true
end
