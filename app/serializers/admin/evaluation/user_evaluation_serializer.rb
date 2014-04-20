class Admin::Evaluation::UserEvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :progress
  has_one :evaluator
  
end
