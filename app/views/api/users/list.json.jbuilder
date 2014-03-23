
json.array!(@users) do |u|
  json.extract! u.user, :id, :name, :role
end
