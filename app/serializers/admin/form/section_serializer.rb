class Admin::Form::SectionSerializer < ActiveModel::Serializer
  
  attributes :id, :form_id, :name, :ordr
  
  has_many :form_comps, serializer: ::Admin::Form::CompSerializer

end
