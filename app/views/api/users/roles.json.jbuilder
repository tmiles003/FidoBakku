
json.array!(@roles) do |role|
  json.s role
  json.l role.capitalize
end
