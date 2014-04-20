class Admin::Form::FormPartSerializer < ActiveModel::Serializer
  
  # from form_part table
  attributes :id, :form_id, :part_id
  
end
