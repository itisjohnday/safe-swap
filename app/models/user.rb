class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :devices, as: :seller
  has_many :devices, as: :buyer
end

class Seller < User
  
end

class Buyer < User
end
