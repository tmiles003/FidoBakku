class Evaluation::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :form_id
  has_one :user
  #has_one :form, serializer: ::Evaluation::FormSerializer
  
end
