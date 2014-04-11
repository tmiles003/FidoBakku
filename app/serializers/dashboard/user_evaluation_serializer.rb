class Dashboard::UserEvaluationSerializer < ActiveModel::Serializer
  attributes :id, :progress, :evaluation_path
  has_one :evaluation, serializer: ::Admin::EvaluationSerializer
  
  def evaluation_path
    root_path(anchor: user_evaluation_path(object))
  end
  
end
