
json.extract! @user_review, 
  :id, :review_title, :user_id, :form_id, :reviewer_id, :created_at, 
  :user_name, :form_name, :reviewer_name, :scores
