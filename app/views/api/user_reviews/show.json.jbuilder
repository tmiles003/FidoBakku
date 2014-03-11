
json.array!(@user_reviews) do |user_review|
  json.extract! user_review, :id, user_id, form_id, reviewer_id, :created_at
  # json.manage_path root_path()
end
