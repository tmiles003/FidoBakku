class UserEvaluationFormSectionSerializer < ActiveModel::Serializer
  attributes :name
  
  has_many :form_comps, serializer: UserEvaluationFormCompSerializer
  
end
