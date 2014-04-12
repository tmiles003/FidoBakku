class Form::FormSectionSerializer < ActiveModel::Serializer
  
  attributes :name, :ordr
  has_many :form_comps, serializer: ::Form::FormCompSerializer
  
end
