class AccountUser < ActiveRecord::Base
  
  belongs_to :account #, -> { includes :users }
  belongs_to :user
  has_many :users
  
  scope :in_role, lambda { |role|
    joins(:user).where('users.role' => role) unless role.nil?
  }

end
