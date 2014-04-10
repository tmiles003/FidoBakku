class UserEvaluationFormSerializer < ActiveModel::Serializer
  #attributes :id
  
  has_many :sections, serializer: UserEvaluationFormSectionSerializer
  
end
