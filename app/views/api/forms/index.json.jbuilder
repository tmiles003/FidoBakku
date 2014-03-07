json.array!(@api_forms) do |api_form|
  json.extract! api_form, :id, :account_id, :name
  json.url api_form_url(api_form, format: :json)
end
