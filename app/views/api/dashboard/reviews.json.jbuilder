
json.array!(@reviews) do |review|
  json.extract! review, :id, :user_id
  json.extract! review.user, :name
  json.user_path root_path(anchor: user_view_path(review.user_id, review.user.slug))
end
