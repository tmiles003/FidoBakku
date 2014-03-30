
json.array!(@account_users) do |user|
  json.extract! user, :id, :name, :email, :role
  json.team_id user.team.nil? ? nil : user.team.id
end
