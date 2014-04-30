class User::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :rating, :done, :evaluation_path
  has_one :evaluation_loop, serializer: ::User::EvaluationLoopSerializer
  
  def evaluation_path
    root_path(anchor: evaluation_feedback_path(object))
  end
  
end
