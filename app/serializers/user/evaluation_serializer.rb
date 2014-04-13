class User::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :rating, :done, :evaluation_path
  has_one :evaluation_session, serializer: ::User::EvaluationSessionSerializer
  
  def evaluation_path
    root_path(anchor: evaluation_feedback_path(object))
  end
  
end
