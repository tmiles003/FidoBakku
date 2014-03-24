
json.array!(@statuses) do |status|
  json.s status
  json.l status.capitalize
end
