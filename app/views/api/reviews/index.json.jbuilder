
json.array!(@reviews) do |review|
  json.extract! review, :id, :title, :open, :archived
  json.manage_path review_manage_path(review, review.slug)
end
