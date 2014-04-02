class FormSerializer < ActiveModel::Serializer
  attributes :id, :name, :component, :parent, :form_path
  
  def form_path
    root_path(anchor: form_manage_path(object))
  end
end
