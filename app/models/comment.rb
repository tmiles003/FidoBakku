class Comment < ActiveRecord::Base
  
  belongs_to :user_review
  
end
