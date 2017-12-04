class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :selling, class_name: 'Device', foreign_key: 'seller_id'
  has_many :buying, class_name: 'Device', foreign_key: 'buyer_id'
  has_many :posts
end