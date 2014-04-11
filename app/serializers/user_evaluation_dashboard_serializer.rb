class UserEvaluationDashboardSerializer < ActiveModel::Serializer
  attributes :id, :user, :progress, :evaluation_path
  
  def user
    #user = ::User.find(object.user_id)
    #user.name
    ::User.select('name, MD5(email) AS email_hash').find(object.user_id)
  end
  
  def evaluation_path
    root_path(anchor: user_evaluation_path(object))
  end
  
end
