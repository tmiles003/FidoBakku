class Evaluation::UserEvaluationSerializer < ActiveModel::Serializer
  attributes :id, :progress, :ratings
  has_one :evaluation, serializer: ::Evaluation::EvaluationSerializer
  
end
