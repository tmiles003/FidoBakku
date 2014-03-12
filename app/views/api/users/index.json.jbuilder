
json.array!(@account_users) do |u|
  json.extract! u.user, :id, :name, :email, :role
end
