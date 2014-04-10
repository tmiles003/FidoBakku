class UserEvaluationFormSectionSerializer < ActiveModel::Serializer
  attributes :name
  
  has_many :comps, serializer: UserEvaluationFormCompSerializer
  
end
