
json.array!(@form_sections) do |form_section|
  json.extract! form_section, :id, :name, :ordr
  # json.url form_section_url(form_section, format: :json)
end
