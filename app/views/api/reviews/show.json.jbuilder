
json.array!(@user_reviews) do |user_review|
  json.extract! user_review, 
    :id, :user_id, :form_id, :reviewer_id, :created_at, 
    :user_name, :form_name, :reviewer_name
end
