
json.array!(@account_users) do |u|
  json.extract! u.user, :id, :name, :email, :role
  # json.url person_url(u, format: :json)
end
