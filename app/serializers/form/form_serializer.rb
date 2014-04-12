class Form::FormSerializer < ActiveModel::Serializer
  
  attributes :ordr
  has_many :form_sections, serializer: ::Form::FormSectionSerializer
  
end
