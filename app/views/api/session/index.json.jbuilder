
json.account do 
  json.id @account.id
  json.name @account.name
end

json.user do
  json.id @user.id
  json.name @user.name
  # user's form?
end

json.abilities do
end
