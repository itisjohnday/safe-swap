class Device < ApplicationRecord
  # belongs_to :user, optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', optional: true
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
  has_many :posts

  def self.search(search)
    where("model ILIKE ? OR manufacturer ILIKE ? OR condition ILIKE ? OR title ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
  end
end
