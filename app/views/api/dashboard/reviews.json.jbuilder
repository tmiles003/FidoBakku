
json.array!(@reviews) do |review|
  json.extract! review, :id, :user_id
  json.extract! review.user, :name
  json.review_path root_path(anchor: user_review_path(review, review.user.slug))
end
