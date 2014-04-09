class FormSerializer < ActiveModel::Serializer
  attributes :id, :name, :shared, :form_path
  
  # null != false...
  def shared
    !!object.shared
  end
  
  def form_path
    root_path(anchor: form_manage_path(object))
  end
end
