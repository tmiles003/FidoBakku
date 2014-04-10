class UserEvaluationSerializer < ActiveModel::Serializer
  attributes :id, :name, :progress, :scores, :evaluation_path
  #has_one :evaluation
  
  def name
    user = ::User.find(object.user_id)
    user.name
  end
  
  def evaluation_path
    root_path(anchor: user_evaluation_path(object))
  end
  
end
