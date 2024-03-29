class Team < ActiveRecord::Base
  
  include InAccount
  
  belongs_to :account
  
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  
  validates :name, length: {
    in: 1..100
  }
  
end
