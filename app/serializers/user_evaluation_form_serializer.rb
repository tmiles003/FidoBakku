class UserEvaluationFormSerializer < ActiveModel::Serializer
  #attributes :id
  
  has_many :form_sections, serializer: UserEvaluationFormSectionSerializer
  
end
