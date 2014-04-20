class AccountUser < ActiveRecord::Base
  
  belongs_to :account #, -> { includes :users }
  belongs_to :user
  
  has_many :users, primary_key: :user_id, foreign_key: :id, dependent: :destroy
  
end
