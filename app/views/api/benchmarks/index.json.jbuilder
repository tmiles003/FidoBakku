
json.array!(@benchmarks) do |benchmark|
  json.extract! benchmark, :id, :topic_id, :content, :ordr
end
