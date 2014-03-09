
json.array!(@form_sections) do |form_section|
  json.extract! form_section, :id, :name, :ordr
end
