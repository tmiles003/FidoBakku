class UserEvaluationSerializer < ActiveModel::Serializer
  attributes :id, :user, :form, :progress, :scores
  #has_one :evaluation
  has_one :user, serializer: UserEvaluationUserSerializer
  has_one :form, serializer: UserEvaluationFormSerializer
  
end
