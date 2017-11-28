class Device < ApplicationRecord
  # belongs_to :user, optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', optional: true
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true


  # alias_attribute :seller, :user
  # alias_attribute :buyer, :user
  # def buyer
  #   User.find(buyer_id)
  # end

  # def seller 
  #   User.find(seller_id)
  # end
end
