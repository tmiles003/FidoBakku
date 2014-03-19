
json.array!(@benchmarks) do |benchmark|
  json.extract! benchmark, :id, :content, :ordr
end
