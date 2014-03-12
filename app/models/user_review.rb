class UserReview < ActiveRecord::Base
  
  has_one :user 
  has_one :form
  # has_one :reviewer
  
end
