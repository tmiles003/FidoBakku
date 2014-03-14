class UserReview < ActiveRecord::Base
  
  belongs_to :review, inverse_of: :user_reviews
  
  has_one :user, primary_key: :user_id, foreign_key: :id
  has_one :form, primary_key: :form_id, foreign_key: :id
  has_one :reviewer, class_name: 'User', primary_key: :reviewer_id, foreign_key: :id
  
end
