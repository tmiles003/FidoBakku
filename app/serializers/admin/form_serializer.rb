class Admin::FormSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :shared, :form_path, :form_part, :form_parts
  has_many :children, serializer: ::Admin::FormFormPartSerializer
  has_many :form_sections, serializer: ::Admin::FormSectionSerializer
  
  # null != false...
  def shared
    !!object.shared
  end
  
  def form_path
    root_path(anchor: admin_form_manage_path(object))
  end
  
  def form_part
    ::FormPart.find_or_create_by(form_id: object.id)
  end
  
  # the possible shared forms to use as "parent"
  def form_parts
    form_parts = ::Form.where(shared: 1).where.not(id: object.id)
    ActiveModel::ArraySerializer.new(form_parts, each_serializer: ::Admin::FormFormPartSerializer)
  end
  
end
