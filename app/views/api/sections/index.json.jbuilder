
json.array!(@form_sections) do |section|
  json.extract! section, :id, :name, :ordr
end
