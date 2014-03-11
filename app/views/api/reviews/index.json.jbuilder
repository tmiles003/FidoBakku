
json.array!(@reviews) do |review|
  json.extract! review, :id, :title, :open, :archived, :created_at
  json.manage_path root_path(anchor: review_manage_path(review, review.slug))
end
