
json.array!(@forms) do |form|
  json.extract! form, :id, :name
end
