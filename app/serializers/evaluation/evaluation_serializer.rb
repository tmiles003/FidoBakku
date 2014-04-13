class Evaluation::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :form_id
  has_one :user
  
end
