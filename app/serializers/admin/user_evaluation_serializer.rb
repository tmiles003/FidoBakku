class Admin::UserEvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :progress, :scores
  has_one :evaluator
  
end
