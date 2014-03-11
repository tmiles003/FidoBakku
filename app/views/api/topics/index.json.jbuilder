
json.array!(@topics) do |topic|
  json.extract! topic, :id, :name, :ordr
end
