class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  
  has_one :account_user, dependent: :destroy
  has_one :account, through: :account_user
  
  has_many :user_reviews
  #has_many :user_reviews, as: :peer_reviews, foreign_key: :reviewer_id
  
end
