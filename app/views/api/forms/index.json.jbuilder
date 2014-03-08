
json.array!(@forms) do |form|
  json.extract! form, :id, :name
  json.manage_path form_manage_path(form)
end
