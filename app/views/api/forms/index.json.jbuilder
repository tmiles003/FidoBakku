
json.array!(@forms) do |form|
  json.extract! form, :id, :name
  # json.url api_form_url(api_form, format: :json)
end
