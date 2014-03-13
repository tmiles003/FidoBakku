class AccountUser < ActiveRecord::Base
	
  belongs_to :account #, -> { includes :users }
  belongs_to :user

end
