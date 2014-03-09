
json.array!(@section_benchmarks) do |benchmark|
  json.extract! benchmark, :id, :content, :ordr
  # json.url benchmark_url(api_benchmark, format: :json)
end
