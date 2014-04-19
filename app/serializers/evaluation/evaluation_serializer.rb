class Evaluation::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :form_id
  has_one :user, serializer: ::BaseUserSerializer
  
end
