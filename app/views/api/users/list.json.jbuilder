
json.array!(@users) do |u|
  json.extract! u.user, :id, :name
end
