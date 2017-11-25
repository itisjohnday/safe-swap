class Device < ApplicationRecord
  belongs_to :seller, class_name: 'User', foreign_key: 'user_id', optional: true
  belongs_to :buyer, class_name: 'User', foreign_key: 'user_id', optional: true

  def buyer
    self.find(:buyer_id)
  end

  def seller 
    self.find(:seller_id)
  end
end
