class EvaluationSessionSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :manage_path
  
  def created_at
    object.created_at.strftime('%s') unless object.created_at.nil?
  end
  
  def manage_path
    root_path(anchor: evaluation_manage_path(object))
  end
end
