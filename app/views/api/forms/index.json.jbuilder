
json.array!(@forms) do |form|
  json.extract! form, :id, :name
  json.manage_path root_path(anchor: form_manage_path(form.id.to_s(36), form.slug))
end
