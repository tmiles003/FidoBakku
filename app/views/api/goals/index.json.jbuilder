
json.array!(@goals) do |goal|
  json.extract! goal, :id, :content
end
