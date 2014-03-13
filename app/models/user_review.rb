class UserReview < ActiveRecord::Base
  
  has_one :user, primary_key: :user_id, foreign_key: :id
  has_one :form
  # has_one :reviewer
  
end
