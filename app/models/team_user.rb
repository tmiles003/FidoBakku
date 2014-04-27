class TeamUser < ActiveRecord::Base
  
  belongs_to :account
  
  belongs_to :team
  belongs_to :user
  
end
