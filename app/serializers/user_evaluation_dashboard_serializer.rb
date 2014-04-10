class UserEvaluationDashboardSerializer < ActiveModel::Serializer
  attributes :id, :name, :progress, :evaluation_path
  
  def name
    user = ::User.find(object.user_id)
    user.name
  end
  
  def evaluation_path
    root_path(anchor: user_evaluation_path(object))
  end
  
end
